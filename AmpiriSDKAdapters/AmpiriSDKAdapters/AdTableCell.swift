//
//  AdTableCell.swift
//  ios-adapters
//
//  Created by  Glispa GmbH on 15/06/16.
//  Copyright © 2016  Glispa GmbH. All rights reserved.
//

import UIKit
import SDWebImage

class SampleTableCell: UITableViewCell {
	@IBOutlet weak var adTitle: UILabel!
	@IBOutlet weak var adText: UILabel!
	@IBOutlet weak var adImage: UIImageView!

	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	func loadWithSampleModel(_ sampleModel: SampleModel) {
		adTitle.text = sampleModel.getTitle()
		adText.text = sampleModel.getText()
        adImage.sd_setImage(with: URL(string: sampleModel.getImageUrl()))
	}
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)

		// Configure the view for the selected state
	}

}
