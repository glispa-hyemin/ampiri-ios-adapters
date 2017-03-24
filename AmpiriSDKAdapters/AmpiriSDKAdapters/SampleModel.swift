import Foundation
class SampleModel {
	let title: String
	let text: String
	let imageUrl: String

	init(title: String, text: String, imageUrl: String) {
		self.text = text
		self.title = title
		self.imageUrl = imageUrl
	}

	func getText() -> String {
		return text
	}

	func getTitle() -> String {
		return title
	}

	func getImageUrl() -> String {
		return imageUrl
	}
}