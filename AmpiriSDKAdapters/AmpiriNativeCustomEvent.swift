import Foundation
import MoPub
import AmpiriSDK



@objc(AmpiriNativeCustomEvent)
open class AmpiriNativeCustomEvent: MPNativeCustomEvent {

	fileprivate var ampiriCustomAdapter: AmpiriCustomAdapter?

	/** @name Requesting a Native Ad */

	/**
	 * Called when the MoPub SDK requires a new native ad.
	 *
	 * When the MoPub SDK receives a response indicating it should load a custom event, it will send
	 * this message to your custom event class. Your implementation should load a native ad from a
	 * third-party ad network.
	 *
	 * @param info A dictionary containing additional custom data associated with a given custom event
	 * request. This data is configurable on the MoPub website, and may be used to pass dynamic
	 * information, such as publisher IDs.
	 */
	open override func requestAd(withCustomEventInfo info: [AnyHashable: Any]!) {

		guard let adUnit = (info["adUnit" as NSObject] as? String) else { reportError("No AdUnit!"); return }

        AmpiriSDK.logEnabled = true
        AmpiriSDK.shared().loadNativeAd(withAdUnitId: adUnit, success: { (nativeAd:AMPNativeAd) -> UIView? in
            nativeAd.setTrackImpression({
                self.ampiriCustomAdapter?.registerImpressionToMopub()
            })
            .setTrackClick({
                self.ampiriCustomAdapter?.registerClickToMopub()
            })
            .setTrackLeftApplication({
                self.ampiriCustomAdapter?.registerFinishHandlingClickToMopub()
            })

            self.ampiriCustomAdapter = AmpiriCustomAdapter(ad: nativeAd)

            let mopubAd = MPNativeAd(adAdapter: self.ampiriCustomAdapter)

            let images = self.getImageUrls(urlStrings: [nativeAd.iconURL, nativeAd.imageURL])


            super.precacheImages(withURLs: images, completionBlock: { [unowned self] (error: [Any]?) in
                if ((error) != nil) {
                    self.delegate.nativeCustomEvent(self, didFailToLoadAdWithError: MPNativeAdNSErrorForImageDownloadFailure())
                } else {
                    self.delegate.nativeCustomEvent(self, didLoad: mopubAd)
                }
            })

            return nil
        }) {[unowned self] (error: AMPError) in
            self.reportError("AmpiriSDK ad load error!")
        }
	}

	func reportError(_ msg: String) {
		delegate.nativeCustomEvent(self, didFailToLoadAdWithError: MPNativeAdNSErrorForInvalidAdServerResponse(msg))
	}
    
    /**
     Removes escape characters from the `urlString` and return an URL object.
     
     - Parameter urlString: string of the url
     - Returns: URL object
     */
    func escapeUrl(urlString:String) -> URL?  {
        guard let escapedUrl = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
            return nil
        }
        
        return  URL(string: escapedUrl)
    }
    
    /**
     Transforms string urls to URL objects.
     
     - Parameter urlStrings: array of string urls
     - Returns: URL array object

    */
    func getImageUrls(urlStrings:[String]) -> [URL] {
        var images = [URL]()
        for urlString in urlStrings {
            if urlString.isEmpty {
                continue
            }
            var url = URL(string: urlString)
            
            if url == nil {
                url = escapeUrl(urlString: urlString)
            }
            
            guard let safeUrl = url  else {
                continue
            }
            
            images.append(safeUrl)
            
        }
        return images
    }
    

}
