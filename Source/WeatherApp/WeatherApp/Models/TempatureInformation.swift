//
//  Tempature.swift
//  WeatherApp
//
//  Created by Ata Cenqiz on 17/04/2018.
//  Copyright © 2018 Mobiquity Inc. All rights reserved.
//

import Foundation

struct TempatureInformation: Codable {
	var current: Double
	var pressure: Int
	var humidity: Int
	var min: Double
	var max: Double
	
	enum CodingKeys: String, CodingKey {
		case current = "temp"
		case pressure
		case humidity
		case min = "temp_min"
		case max = "temp_max"
	}
}
