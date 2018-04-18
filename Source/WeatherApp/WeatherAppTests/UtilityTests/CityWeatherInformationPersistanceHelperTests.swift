//
//  CityWeatherInformationPersistanceHelperTests.swift
//  WeatherAppTests
//
//  Created by Ata Cenqiz on 18/04/2018.
//  Copyright © 2018 Mobiquity Inc. All rights reserved.
//

import XCTest
@testable import WeatherApp

class CityWeatherInformationPersistanceHelperTests: XCTestCase {
	
	var sut: CityWeatherPersistanceHelperImplementation!
	var userDefaultsHelperMock: UserDefaultsHelperMock!
	
	override func setUp() {
		super.setUp()
		
		userDefaultsHelperMock = UserDefaultsHelperMock()
		sut = CityWeatherPersistanceHelperImplementation(userDefaultsHelper: userDefaultsHelperMock)
	}
	
	func testStoreCityInformation() {
		let cityInfo1 = CityWeatherInformation(id: 1, name: "test1", weather: [], tempature: TempatureInformation(current: 1.0, pressure: 1, humidity: 2, min: 3.0, max: 4.0), wind: WindInformation(speed: 1.0, deg: 2.0))
		
		sut.storeCityInformation(info: cityInfo1)
		
		let savedCities = userDefaultsHelperMock.get(key: UserDefaultsConstants.savedCitySearch)
		XCTAssertNotNil(savedCities)
	}
	
	func testGetStoredCityInformation() {
		let cityInfo = [CityWeatherInformation(id: 1, name: "test1", weather: [], tempature: TempatureInformation(current: 1.0, pressure: 1, humidity: 2, min: 3.0, max: 4.0), wind: WindInformation(speed: 1.0, deg: 2.0))]
		
		let encoder = JSONEncoder()
		if let encoded = try? encoder.encode(cityInfo) {
			userDefaultsHelperMock.save(key: UserDefaultsConstants.savedCitySearch, value: encoded)
		}
		
		let storedCities = sut.getStoredCityInformation()
		XCTAssertNotNil(storedCities)
		XCTAssertEqual(storedCities?.count, 1)
	}
}
