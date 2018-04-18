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
	func removeCityInformation(info: CityWeatherInformation)
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
		
		storeCities(array: storedCities)
	}
	
	func getStoredCityInformation() -> [CityWeatherInformation]? {
		guard let storedCitiesData = userDefaultsHelper.get(key: UserDefaultsConstants.savedCitySearch) as? Data else { return nil }
		
		let decoder = JSONDecoder()
		if let storedCities = try? decoder.decode(Array<CityWeatherInformation>.self, from: storedCitiesData) {
			return storedCities
		}
		
		return nil
	}
	
	func removeCityInformation(info: CityWeatherInformation) {
		guard var storedCities = getStoredCityInformation() else { return }
		let index = storedCities.index { object -> Bool in
			return object.id == info.id
		}
		
		guard let arrayIndex = index else { return }
		storedCities.remove(at: arrayIndex)
		
		storeCities(array: storedCities)
	}
	
	private func storeCities(array: [CityWeatherInformation]?) {
		let encoder = JSONEncoder()
		if let encoded = try? encoder.encode(array) {
			userDefaultsHelper.save(key: UserDefaultsConstants.savedCitySearch, value: encoded)
		}
	}
}
