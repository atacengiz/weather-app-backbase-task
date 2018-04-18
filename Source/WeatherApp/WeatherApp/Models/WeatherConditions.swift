//
//  Weather.swift
//  WeatherApp
//
//  Created by Ata Cenqiz on 17/04/2018.
//  Copyright © 2018 Mobiquity Inc. All rights reserved.
//

import Foundation

struct WeatherConditions: Codable {
	var id: Int
	var main: String
	var description: String
	var icon: String
}
