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
	
	// MARK: Public variables
	weak var viewController: CityInformationViewController?
	var cityWeatherInformation: CityWeatherInformation?
	
	init(currentWeatherDataService: CurrentWeatherDataService) {
		self.currentWeatherDataService = currentWeatherDataService
	}
	
	func getWeatherData(longitude: Double, latitude: Double) {
		currentWeatherDataService.getWeatherInformation(longitude: longitude, latitude: latitude, successHandler: { [weak self] cityWeatherInformation in
			self?.cityWeatherInformation = cityWeatherInformation
			
			DispatchQueue.main.async { [weak self] in
				self?.viewController?.show(cityWeatherInformation: cityWeatherInformation)
			}
		}, errorHandler: { [weak self] error in
			self?.cityWeatherInformation = nil
			print(error)
		}) { [weak self] in
			DispatchQueue.main.async { [weak self] in
				self?.viewController?.showResponse(isSuccess: self?.cityWeatherInformation != nil)
			}
		}
	}
}
