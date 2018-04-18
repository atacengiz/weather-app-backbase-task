//
//  CityWeatherInformationPersistanceHelper.swift
//  WeatherApp
//
//  Created by Ata Cenqiz on 18/04/2018.
//  Copyright © 2018 Mobiquity Inc. All rights reserved.
//

import Foundation

protocol CityWeatherPersistanceHelper {
	func storeCityInformation(info: CityWeatherInformation)
	func getStoredCityInformation() -> [CityWeatherInformation]?
}

struct CityWeatherPersistanceHelperImplementation: CityWeatherPersistanceHelper {
	
	var userDefaultsHelper: UserDefaultsHelper
	
	func storeCityInformation(info: CityWeatherInformation) {
		var storedCities = getStoredCityInformation()
		if storedCities == nil {
			storedCities = [info]
		}
		else {
			storedCities?.append(info)
		}
		
		let encoder = JSONEncoder()
		if let encoded = try? encoder.encode(storedCities) {
			userDefaultsHelper.save(key: UserDefaultsConstants.savedCitySearch, value: encoded)
		}
	}
	
	func getStoredCityInformation() -> [CityWeatherInformation]? {
		guard let storedCitiesData = userDefaultsHelper.get(key: UserDefaultsConstants.savedCitySearch) as? Data else { return nil }
		
		let decoder = JSONDecoder()
		if let storedCities = try? decoder.decode(Array<CityWeatherInformation>.self, from: storedCitiesData) {
			return storedCities
		}
		
		return nil
	}
}
