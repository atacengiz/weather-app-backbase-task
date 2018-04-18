//
//  HomeTableViewCell.swift
//  WeatherApp
//
//  Created by Ata Cenqiz on 18/04/2018.
//  Copyright © 2018 Mobiquity Inc. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
	
	@IBOutlet weak private var cityNameLabel: UILabel!
	
	func setCity(name: String) {
		cityNameLabel.text = name
	}
}
