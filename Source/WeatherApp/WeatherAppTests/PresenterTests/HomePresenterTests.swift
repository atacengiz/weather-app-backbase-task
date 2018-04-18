//
//  HomePresenterTests.swift
//  WeatherAppTests
//
//  Created by Ata Cenqiz on 18/04/2018.
//  Copyright © 2018 Mobiquity Inc. All rights reserved.
//

import XCTest
@testable import WeatherApp

class HomeViewControllerMock: HomeViewControllerType {
	var isUpdateStoredCitiesGotCalled = false
	var cities: [CityWeatherInformation]?
	
	func updateStoredCities(cities: [CityWeatherInformation]) {
		isUpdateStoredCitiesGotCalled = true
		self.cities = cities
	}
}

class HomePresenterTests: XCTestCase {
	
	var sut: HomePresenterImplementation!
	var cityWeatherPersistanceHelperMock: CityWeatherPersistanceHelperMock!
	var homeViewControllerMock: HomeViewControllerMock!
	
	override func setUp() {
		super.setUp()
		
		cityWeatherPersistanceHelperMock = CityWeatherPersistanceHelperMock()
		homeViewControllerMock = HomeViewControllerMock()
		sut = HomePresenterImplementation(cityWeatherPersistanceHelper: cityWeatherPersistanceHelperMock, viewController: homeViewControllerMock)
	}
	
	func testShowStoredCities() {
		let cityInfo = [CityWeatherInformation(id: 1, name: "test1", weather: [], tempature: TempatureInformation(current: 1.0, humidity: 2), wind: WindInformation(speed: 1.0), coord: Coordinates(lon: 1.0, lat: 1.0))]

		cityWeatherPersistanceHelperMock.storedCityInfoToReturn = cityInfo
		
		sut.showStoredCities()
		
		XCTAssertTrue(cityWeatherPersistanceHelperMock.isGetStoredCityInformatioGotCalled)
		
		XCTAssertTrue(homeViewControllerMock.isUpdateStoredCitiesGotCalled)
		XCTAssertEqual(homeViewControllerMock.cities?.count, 1)
	}
	
	func testRemoveStoredCity() {
		let cityInfo = CityWeatherInformation(id: 1, name: "test1", weather: [], tempature: TempatureInformation(current: 1.0, humidity: 2), wind: WindInformation(speed: 1.0), coord: Coordinates(lon: 1.0, lat: 1.0))
		
		sut.removeCity(cityInfo: cityInfo)
		
		XCTAssertTrue(cityWeatherPersistanceHelperMock.isRemoveCityInformationGotCalled)
		XCTAssertEqual(cityWeatherPersistanceHelperMock.removedCityInfo?.id, 1)
	}
}
