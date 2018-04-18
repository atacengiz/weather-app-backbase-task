//
//  CityInformationCollectionViewCell.swift
//  WeatherApp
//
//  Created by Ata Cenqiz on 18/04/2018.
//  Copyright © 2018 Mobiquity Inc. All rights reserved.
//

import UIKit

class CityInformationCollectionViewCell: UICollectionViewCell {
	
	@IBOutlet private weak var descriptionLabel: UILabel!
	@IBOutlet private weak var iconImageView: UIImageView!
	
	func set(weatherDescription: String, iconName: String) {
		descriptionLabel.text = weatherDescription
		iconImageView.image = UIImage(named: iconName)
	}
}
