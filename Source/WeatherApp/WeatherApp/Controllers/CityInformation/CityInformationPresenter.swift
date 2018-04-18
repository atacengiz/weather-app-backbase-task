//
//  CityInformationPresenter.swift
//  WeatherApp
//
//  Created by Ata Cenqiz on 18/04/2018.
//  Copyright © 2018 Mobiquity Inc. All rights reserved.
//

import Foundation

protocol CityInformationPresenter {
	func getWeatherData(longitude: Double, latitude: Double)
}

class CityInformationPresenterImplementation: CityInformationPresenter {
	// MARK: Private variables
	private let currentWeatherDataService: CurrentWeatherDataService
	private let cityWeatherPersistanceHelper: CityWeatherPersistanceHelper
	private let userDefaultsHelper: UserDefaultsHelper
	
	// MARK: Public variables
	weak var viewController: CityInformationViewController?
	var cityWeatherInformation: CityWeatherInformation?
	
	init(currentWeatherDataService: CurrentWeatherDataService, cityWeatherPersistanceHelper: CityWeatherPersistanceHelper, userDefaultsHelper: UserDefaultsHelper) {
		self.currentWeatherDataService = currentWeatherDataService
		self.cityWeatherPersistanceHelper = cityWeatherPersistanceHelper
		self.userDefaultsHelper = userDefaultsHelper
	}
	
	func getWeatherData(longitude: Double, latitude: Double) {
		let unit = getPreferedUnit()
		
		currentWeatherDataService.getWeatherInformation(longitude: longitude, latitude: latitude, unit: unit.type(), successHandler: { [weak self] cityWeatherInformation in
			self?.cityWeatherInformation = cityWeatherInformation
			self?.cityWeatherPersistanceHelper.storeCityInformation(info: cityWeatherInformation)
			
			DispatchQueue.main.async { [weak self] in
				self?.viewController?.show(cityWeatherInformation: cityWeatherInformation, unit: unit.rawValue)
				self?.viewController?.showResponse(isSuccess: true)
			}
		}, errorHandler: { [weak self] error in
			self?.cityWeatherInformation = nil
			print(error)
			DispatchQueue.main.async { [weak self] in
				self?.viewController?.showResponse(isSuccess: false)
			}
		})
	}
	
	private func getPreferedUnit() -> TempatureUnit {
		guard let unitString = userDefaultsHelper.get(key: UserDefaultsConstants.preferredUnit) as? String else { return TempatureUnit.celcius }
		if let unit = TempatureUnit(rawValue: unitString) {
			return unit
		}
		else {
			return TempatureUnit.celcius
		}
	}
}
