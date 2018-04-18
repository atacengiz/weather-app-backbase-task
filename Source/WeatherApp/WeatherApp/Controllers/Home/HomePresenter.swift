//
//  HomePresenter.swift
//  WeatherApp
//
//  Created by Ata Cenqiz on 18/04/2018.
//  Copyright © 2018 Mobiquity Inc. All rights reserved.
//

import Foundation

protocol HomePresenter {
	func showStoredCities()
	func removeCity(cityInfo: CityWeatherInformation)
}

class HomePresenterImplementation: HomePresenter {
	
	// MARK: Private variables
	private let cityWeatherPersistanceHelper: CityWeatherPersistanceHelper
	private let viewController: HomeViewControllerType

	init(cityWeatherPersistanceHelper: CityWeatherPersistanceHelper, viewController: HomeViewControllerType) {
		self.cityWeatherPersistanceHelper = cityWeatherPersistanceHelper
		self.viewController = viewController
	}
	
	func showStoredCities() {
		guard let storedCities = cityWeatherPersistanceHelper.getStoredCityInformation() else { return }
		viewController.updateStoredCities(cities: storedCities)
	}
	
	func removeCity(cityInfo: CityWeatherInformation) {
		cityWeatherPersistanceHelper.removeCityInformation(info: cityInfo)
	}
}
