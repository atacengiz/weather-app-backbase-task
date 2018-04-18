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
	var humidity: Int
	
	enum CodingKeys: String, CodingKey {
		case current = "temp"
		case humidity
	}
}
