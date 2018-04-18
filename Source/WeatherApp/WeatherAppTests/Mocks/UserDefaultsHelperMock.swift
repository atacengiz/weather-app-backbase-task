//
//  UserDefaultsHelperMock.swift
//  WeatherAppTests
//
//  Created by Ata Cenqiz on 18/04/2018.
//  Copyright © 2018 Mobiquity Inc. All rights reserved.
//

import Foundation
@testable import WeatherApp

class UserDefaultsHelperMock: UserDefaultsHelper {
	var dict = [String: AnyObject]()
	
	func save(key: String, value: Any) {
		dict[key] = (value as AnyObject)
	}
	
	func get(key: String) -> Any? {
		return dict[key]
	}
	
	func remove(key: String) {
		dict.removeValue(forKey: key)
	}
	
	func sync() { }
}
