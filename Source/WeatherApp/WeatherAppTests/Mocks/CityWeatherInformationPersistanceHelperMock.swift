//
//  CityWeatherInformationPersistanceHelperMock.swift
//  WeatherAppTests
//
//  Created by Ata Cenqiz on 18/04/2018.
//  Copyright © 2018 Mobiquity Inc. All rights reserved.
//

import Foundation
@testable import WeatherApp

class CityWeatherPersistanceHelperMock: CityWeatherPersistanceHelper {
	var isStoreCityInformationGotCalled = false
	var storedCityInfo: CityWeatherInformation?
	
	var isGetStoredCityInformatioGotCalled = false
	var storedCityInfoToReturn: [CityWeatherInformation]?
	
	var isRemoveCityInformationGotCalled = false
	var removedCityInfo: CityWeatherInformation?
	
	func storeCityInformation(info: CityWeatherInformation) {
		isStoreCityInformationGotCalled = true
		storedCityInfo = info
	}
	
	func getStoredCityInformation() -> [CityWeatherInformation]? {
		isGetStoredCityInformatioGotCalled = true
		return storedCityInfoToReturn
	}
	
	func removeCityInformation(info: CityWeatherInformation) {
		isRemoveCityInformationGotCalled = true
		removedCityInfo = info
	}
}
