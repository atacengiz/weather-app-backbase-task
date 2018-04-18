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
	
	// MARK: Public variables
	weak var viewController: CityInformationViewController?
	var cityWeatherInformation: CityWeatherInformation?
	
	init(currentWeatherDataService: CurrentWeatherDataService, cityWeatherPersistanceHelper: CityWeatherPersistanceHelper) {
		self.currentWeatherDataService = currentWeatherDataService
		self.cityWeatherPersistanceHelper = cityWeatherPersistanceHelper
	}
	
	func getWeatherData(longitude: Double, latitude: Double) {
		currentWeatherDataService.getWeatherInformation(longitude: longitude, latitude: latitude, successHandler: { [weak self] cityWeatherInformation in
			self?.cityWeatherInformation = cityWeatherInformation
			self?.cityWeatherPersistanceHelper.storeCityInformation(info: cityWeatherInformation)
			
			DispatchQueue.main.async { [weak self] in
				self?.viewController?.show(cityWeatherInformation: cityWeatherInformation)
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
}
