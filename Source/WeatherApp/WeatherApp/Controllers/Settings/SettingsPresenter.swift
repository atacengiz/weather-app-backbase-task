//
//  SettingsPresenter.swift
//  WeatherApp
//
//  Created by Ata Cenqiz on 18/04/2018.
//  Copyright © 2018 Mobiquity Inc. All rights reserved.
//

import Foundation

enum TempatureUnit: String {
	case celcius = "°C"
	case fahrenheit = "°F"
	
	func type() -> String {
		switch self {
		case .celcius:
			return "metric"
		case .fahrenheit:
			return "imperial"
		}
	}
}

class SettingsPresenter {
	
	private let userDefaultsHelper: UserDefaultsHelper
	
	init(userDefaultsHelper: UserDefaultsHelper) {
		self.userDefaultsHelper = userDefaultsHelper
	}
	
	func getPreferredUnit() -> TempatureUnit {
		guard let unit = userDefaultsHelper.get(key: UserDefaultsConstants.preferredUnit) as? String else { return TempatureUnit.celcius }
		if let tempatureUnit = TempatureUnit(rawValue: unit) {
			return tempatureUnit
		}
		else {
			return TempatureUnit.celcius
		}
	}
	
	func setPreferedUnit(unit: TempatureUnit) {
		userDefaultsHelper.save(key: UserDefaultsConstants.preferredUnit, value: unit.rawValue)
	}
}
