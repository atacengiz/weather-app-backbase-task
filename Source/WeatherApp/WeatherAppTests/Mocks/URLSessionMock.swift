//
//  URLSessionMock.swift
//  WeatherAppTests
//
//  Created by Ata Cenqiz on 17/04/2018.
//  Copyright © 2018 Mobiquity Inc. All rights reserved.
//

import Foundation

class URLSessionMock: URLSession {
	typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void

	var data: Data?
	var response: HTTPURLResponse?
	var error: Error?
	
	override func dataTask(with url: URL, completionHandler: @escaping CompletionHandler) -> URLSessionDataTask {
		let data = self.data
		let error = self.error
		let response = self.response
		
		return URLSessionDataTaskMock {
			completionHandler(data, response, error)
		}
	}
}
