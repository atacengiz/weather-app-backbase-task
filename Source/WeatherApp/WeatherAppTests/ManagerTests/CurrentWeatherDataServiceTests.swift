//
//  CurrentWeatherDataServiceTests.swift
//  WeatherAppTests
//
//  Created by Ata Cenqiz on 17/04/2018.
//  Copyright © 2018 Mobiquity Inc. All rights reserved.
//

import XCTest
@testable import WeatherApp

class CurrentWeatherDataServiceTests: XCTestCase {
	
	var sut: CurrentWeatherDataService!
	var sessionMock: URLSessionMock!
	var urlSessionDataTaskMock: URLSessionDataTaskMock!
	
	override func setUp() {
		super.setUp()
		
		sessionMock = URLSessionMock()
		sut = CurrentWeatherDataServiceImplementation(session: sessionMock)
	}
	
	func testGetWeatherInformationReturnsCityWeatherInformation() {
		sessionMock.response = HTTPURLResponse(url: URL(string: ServiceConstants.serverURL)!, statusCode: 200, httpVersion: nil, headerFields: nil)
		
		let dummyJSONResponse = "{\"coord\":{\"lon\":139,\"lat\":35},\"weather\":[{\"id\":521,\"main\":\"Rain\",\"description\":\"showerrain\",\"icon\":\"09n\"},{\"id\":701,\"main\":\"Mist\",\"description\":\"mist\",\"icon\":\"50n\"}],\"base\":\"stations\",\"main\":{\"temp\":12,\"pressure\":1022,\"humidity\":93,\"temp_min\":11,\"temp_max\":13},\"visibility\":2816,\"wind\":{\"speed\":2.6,\"deg\":330},\"clouds\":{\"all\":90},\"dt\":1523967780,\"sys\":{\"type\":1,\"id\":7618,\"message\":0.005,\"country\":\"JP\",\"sunrise\":1523909372,\"sunset\":1523956685},\"id\":1851632,\"name\":\"Shuzenji\",\"cod\":200}"
		sessionMock.data = dummyJSONResponse.data(using: .utf8)
		
		let latitude = 12.0
		let longitude = 120.0
		sut.getWeatherInformation(longitude: longitude, latitude: latitude, unit: "metric", successHandler: { cityWeatherInformation in
			XCTAssertNotNil(cityWeatherInformation)
			XCTAssertEqual(cityWeatherInformation.id, 1851632)
			XCTAssertEqual(cityWeatherInformation.name, "Shuzenji")
			
			XCTAssertEqual(cityWeatherInformation.tempature.current, 12)
			XCTAssertEqual(cityWeatherInformation.tempature.humidity, 93)
			
			XCTAssertEqual(cityWeatherInformation.wind.speed, 2.6)
		}, errorHandler: { _ in
			
		})
	}
	
	func testGetWeatherInformationFailsWithConnectionIssue() {
		sessionMock.error = NSError(domain: "testDomain", code: 1, userInfo: nil)
		
		let latitude = 12.0
		let longitude = 120.0
		sut.getWeatherInformation(longitude: longitude, latitude: latitude, unit: "metric", successHandler: { _ in
			
		}, errorHandler: { error in
			XCTAssertNotNil(error)
			XCTAssertNotNil(error.localizedDescription)
		})
	}
	
	func testGetWeatherInformationWithUnexpectedResponse() {
		sessionMock.response = HTTPURLResponse(url: URL(string: ServiceConstants.serverURL)!, statusCode: 200, httpVersion: nil, headerFields: nil)
		
		let dummyJSONResponse = "{\"dummyKey\": \"dummyValue\"}"
		sessionMock.data = dummyJSONResponse.data(using: .utf8)
		
		let latitude = 12.0
		let longitude = 120.0
		sut.getWeatherInformation(longitude: longitude, latitude: latitude, unit: "metric", successHandler: { _ in

		}, errorHandler: { error in
			XCTAssertNotNil(error)
			XCTAssertEqual(error, CurrentWeatherDataError.responseFormatNotExpected)
		})
	}
}

