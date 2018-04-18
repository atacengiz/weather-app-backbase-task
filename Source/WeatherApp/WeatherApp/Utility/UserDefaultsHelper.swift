//
//  UserDefaultsHelper.swift
//  WeatherApp
//
//  Created by Ata Cenqiz on 18/04/2018.
//  Copyright © 2018 Mobiquity Inc. All rights reserved.
//

import Foundation

protocol UserDefaultsHelper {
	func save(key: String, value: Any)
	func get(key: String) -> Any?
	func remove(key: String)
	func sync()
}

class UserDefaultsHelperImplementation: UserDefaultsHelper {
	func save(key: String, value: Any) {
		UserDefaults.standard.set(value, forKey: key)
	}
	
	func get(key: String) -> Any? {
		return UserDefaults.standard.object(forKey: key)
	}
	
	func remove(key: String) {
		UserDefaults.standard.removeObject(forKey: key)
	}
	
	func sync() {
		UserDefaults.standard.synchronize()
	}
}
