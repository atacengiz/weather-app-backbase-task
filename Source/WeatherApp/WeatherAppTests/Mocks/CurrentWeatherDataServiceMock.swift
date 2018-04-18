//
//  CurrentWeatherDataServiceMock.swift
//  WeatherAppTests
//
//  Created by Ata Cenqiz on 17/04/2018.
//  Copyright © 2018 Mobiquity Inc. All rights reserved.
//

import Foundation
@testable import WeatherApp

class CurrentWeatherDataServiceMock: CurrentWeatherDataService {
	var isGetWeatherInformationCalled = false
	var longitude: Double?
	var latitude: Double?
	
	var cityWeatherInformationToReturn: CityWeatherInformation?
	var errorToReturn: CurrentWeatherDataError?
	
	func getWeatherInformation(longitude: Double, latitude: Double, unit: String, successHandler: @escaping CurrentWeatherDataSuccessHandler, errorHandler: @escaping CurrentWeatherDataErrorHandler) {
		isGetWeatherInformationCalled = true
		self.longitude = longitude
		self.latitude = latitude
		
		if let cityWeatherInformationToReturn = cityWeatherInformationToReturn {
			successHandler(cityWeatherInformationToReturn)
		}
		else if let errorToReturn = errorToReturn {
			errorHandler(errorToReturn)
		}
	}
}
