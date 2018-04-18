//
//  CityInformationPresenterTests.swift
//  WeatherAppTests
//
//  Created by Ata Cenqiz on 18/04/2018.
//  Copyright © 2018 Mobiquity Inc. All rights reserved.
//

import XCTest
@testable import WeatherApp

class CityInformationPresenterTests: XCTestCase {
	
	var sut: CityInformationPresenter!
	var currentWeatherDataServiceMock: CurrentWeatherDataServiceMock!
	var cityWeatherPersistaneHelperMock: CityWeatherPersistanceHelperMock!
	
	override func setUp() {
		super.setUp()
		
		currentWeatherDataServiceMock = CurrentWeatherDataServiceMock()
		cityWeatherPersistaneHelperMock = CityWeatherPersistanceHelperMock()
		sut = CityInformationPresenterImplementation(currentWeatherDataService: currentWeatherDataServiceMock, cityWeatherPersistanceHelper: cityWeatherPersistaneHelperMock, userDefaultsHelper: UserDefaultsHelperMock())
	}
	
	override func tearDown() {
		cityWeatherPersistaneHelperMock = nil
		currentWeatherDataServiceMock = nil
		sut = nil
		
		super.tearDown()
	}
	
	func testGetWeatherDataSuccessAndStoresCityInfo() {
		currentWeatherDataServiceMock.cityWeatherInformationToReturn = CityWeatherInformation(id: 1, name: "test1", weather: [], tempature: TempatureInformation(current: 1.0, pressure: 1, humidity: 2, min: 3.0, max: 4.0), wind: WindInformation(speed: 1.0, deg: 2.0), coord: Coordinates(lon: 1.0, lat: 1.0))
		
		let longitude = 2.0
		let latitude = 3.0
		sut.getWeatherData(longitude: longitude, latitude: latitude)
		
		XCTAssertTrue(currentWeatherDataServiceMock.isGetWeatherInformationCalled)
		XCTAssertEqual(currentWeatherDataServiceMock.latitude, latitude)
		XCTAssertEqual(currentWeatherDataServiceMock.longitude, longitude)
		
		XCTAssertTrue(cityWeatherPersistaneHelperMock.isStoreCityInformationGotCalled)
		XCTAssertEqual(cityWeatherPersistaneHelperMock.storedCityInfo?.id, 1)
	}
	
	func testGetWeatherDataFailed() {
		currentWeatherDataServiceMock.errorToReturn = CurrentWeatherDataError.responseFormatNotExpected
		
		let longitude = 2.0
		let latitude = 3.0
		sut.getWeatherData(longitude: longitude, latitude: latitude)
		
		XCTAssertTrue(currentWeatherDataServiceMock.isGetWeatherInformationCalled)
		XCTAssertEqual(currentWeatherDataServiceMock.latitude, latitude)
		XCTAssertEqual(currentWeatherDataServiceMock.longitude, longitude)
		
		XCTAssertFalse(cityWeatherPersistaneHelperMock.isStoreCityInformationGotCalled)
	}
}
