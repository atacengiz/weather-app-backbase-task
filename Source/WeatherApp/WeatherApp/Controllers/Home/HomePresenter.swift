//
//  HomePresenter.swift
//  WeatherApp
//
//  Created by Ata Cenqiz on 18/04/2018.
//  Copyright © 2018 Mobiquity Inc. All rights reserved.
//

import Foundation

protocol HomePresenter {
	func getWeatherData(longitude: Double, latitude: Double)
}

class HomePresenterImplementation: HomePresenter {
	
	let currentWeatherDataService: CurrentWeatherDataService
	
	init(currentWeatherDataService: CurrentWeatherDataService) {
		self.currentWeatherDataService = currentWeatherDataService
	}
	
	func getWeatherData(longitude: Double, latitude: Double) {
		currentWeatherDataService.getWeatherInformation(longitude: longitude, latitude: latitude, successHandler: { cityWeatherInformation in
			
		}, errorHandler: { error in
			
		}) {
			
		}
	}
}