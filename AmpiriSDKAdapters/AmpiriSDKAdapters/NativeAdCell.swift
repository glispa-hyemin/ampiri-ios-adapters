import UIKit
import MoPub
class NativeAdCell: UITableViewCell, MPNativeAdRendering {

	// MARK: Properties

	@IBOutlet weak var titleLabel: UILabel!

	@IBOutlet weak var mainTextLabel: UILabel!

	@IBOutlet weak var callToActionButton: UILabel!

	@IBOutlet weak var mainImageView: UIImageView!

	@IBOutlet weak var videoView: UIView!

	@IBOutlet weak var iconImageView: UIImageView!

	@IBOutlet weak var privacyInformationIconImageView: UIImageView!

	@IBOutlet weak var containerView: UIView!

	override func awakeFromNib() {

	}

	// MARK: MPNativeAdRendering

	func nativeMainTextLabel() -> UILabel! {
		return self.mainTextLabel
	}

	func nativeTitleTextLabel() -> UILabel! {
		return self.titleLabel
	}

	func nativeCallToActionTextLabel() -> UILabel! {
		return self.callToActionButton
	}

	func nativeIconImageView() -> UIImageView! {
		return self.iconImageView
	}

	func nativeMainImageView() -> UIImageView! {
		return self.mainImageView
	}

	func nativeVideoView() -> UIView! {
		return self.videoView
	}

	func nativePrivacyInformationIconImageView() -> UIImageView! {
		return self.privacyInformationIconImageView
	}

	// Return the nib used for the native ad.
	class func nibForAd() -> UINib! {
		return UINib(nibName: "NativeAdCell", bundle: nil)
	}

}
