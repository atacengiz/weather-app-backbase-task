//
//  SettingsPresenterTests.swift
//  WeatherAppTests
//
//  Created by Ata Cenqiz on 18/04/2018.
//  Copyright © 2018 Mobiquity Inc. All rights reserved.
//

import XCTest
@testable import WeatherApp

class SettingsPresenterTests: XCTestCase {
	
	var sut: SettingsPresenter!
	var userDefaultsHelperMock: UserDefaultsHelperMock!
	
	override func setUp() {
		super.setUp()
		
		userDefaultsHelperMock = UserDefaultsHelperMock()
		sut = SettingsPresenter(userDefaultsHelper: userDefaultsHelperMock)
	}
	
	func testGetPreferedUnitReturnDefault() {
		let unit = sut.getPreferredUnit()
		
		XCTAssertEqual(unit, .celcius)
	}
	
	func testGetPreferedUnitWithWrongValue() {
		userDefaultsHelperMock.save(key: UserDefaultsConstants.preferredUnit, value: "dummy")
		let unit = sut.getPreferredUnit()
		
		XCTAssertEqual(unit, .celcius)
	}
	
	func testGetPreferredUnitWithSavedValue() {
		userDefaultsHelperMock.save(key: UserDefaultsConstants.preferredUnit, value: "°F")
		let unit = sut.getPreferredUnit()
		
		XCTAssertEqual(unit, .fahrenheit)
	}
	
	func testSetPreferedUnit() {
		sut.setPreferedUnit(unit: .fahrenheit)
		
		let savedUnit = userDefaultsHelperMock.get(key: UserDefaultsConstants.preferredUnit) as? String
		XCTAssertEqual(savedUnit, "°F")
	}
}
