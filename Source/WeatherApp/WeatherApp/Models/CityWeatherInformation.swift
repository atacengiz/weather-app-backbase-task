//
//  City.swift
//  WeatherApp
//
//  Created by Ata Cenqiz on 17/04/2018.
//  Copyright © 2018 Mobiquity Inc. All rights reserved.
//

import Foundation

struct CityWeatherInformation: Codable {
	var id: Int
	var name: String
	var weather: [WeatherConditions]
	var tempature: TempatureInformation
	var wind: WindInformation
	
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case weather
		case tempature = "main"
		case wind
	}
}
