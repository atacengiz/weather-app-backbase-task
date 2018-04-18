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
	
	// MARK: Public variables
	
	// MARK: Private variables
	private let cityWeatherPersistanceHelper: CityWeatherPersistanceHelper
	private weak var viewController: HomeViewController?

	init(cityWeatherPersistanceHelper: CityWeatherPersistanceHelper, viewController: HomeViewController) {
		self.cityWeatherPersistanceHelper = cityWeatherPersistanceHelper
		self.viewController = viewController
	}
	
	func showStoredCities() {
		guard let storedCities = cityWeatherPersistanceHelper.getStoredCityInformation() else { return }
		viewController?.updateStoredCities(cities: storedCities)
	}
	
	func removeCity(cityInfo: CityWeatherInformation) {
		cityWeatherPersistanceHelper.removeCityInformation(info: cityInfo)
	}
}
