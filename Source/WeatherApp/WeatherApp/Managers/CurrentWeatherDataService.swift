//
//  CurrentWeatherDataManager.swift
//  WeatherApp
//
//  Created by Ata Cenqiz on 17/04/2018.
//  Copyright © 2018 Mobiquity Inc. All rights reserved.
//

import Foundation

typealias CurrentWeatherDataSuccessHandler = (CityWeatherInformation) -> Void
typealias CurrentWeatherDataErrorHandler = (CurrentWeatherDataError) -> Void
typealias ServiceCompletionHandler = () -> Void

enum CurrentWeatherDataError: Error, Equatable {
	case connectionError(String?)
	case responseFormatNotExpected
}

protocol CurrentWeatherDataService {
	func getWeatherInformation(longitude: Double, latitude: Double, successHandler: @escaping CurrentWeatherDataSuccessHandler, errorHandler: @escaping CurrentWeatherDataErrorHandler, completionHandler: @escaping ServiceCompletionHandler)
}

class CurrentWeatherDataServiceImplementation: CurrentWeatherDataService {
	private var session: URLSession
	var dataTask: URLSessionDataTask?
	
	init(session: URLSession = .shared) {
		self.session = session
	}
	
	func getWeatherInformation(longitude: Double, latitude: Double, successHandler: @escaping (CityWeatherInformation) -> Void, errorHandler: @escaping (CurrentWeatherDataError) -> Void, completionHandler: @escaping () -> Void) {
		
		dataTask?.cancel()
		
		if var urlComponents = URLComponents(string: ServiceConstants.serverURL) {
			let queryComponents: [URLQueryItem] = [
				URLQueryItem(name: "lat", value: String(latitude)),
				URLQueryItem(name: "lon", value: String(longitude)),
				URLQueryItem(name: "units", value: "metric"),
				URLQueryItem(name: "APPID", value: ServiceConstants.appId)
			]
			urlComponents.queryItems = queryComponents

			guard let url = urlComponents.url else { return }
			dataTask = session.dataTask(with: url) { data, response, error in
				if let error = error {
					errorHandler(CurrentWeatherDataError.connectionError(error.localizedDescription))
				}
				else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
					if let cityInformation = try? JSONDecoder().decode(CityWeatherInformation.self, from: data) {
						successHandler(cityInformation)
					}
					else {
						errorHandler(CurrentWeatherDataError.responseFormatNotExpected)
					}
				}
				else {
					errorHandler(CurrentWeatherDataError.connectionError(nil))
				}
				
				completionHandler()
			}

			dataTask?.resume()
		}
	}
}
