//
//  URLSessionDataTaskMock.swift
//  WeatherAppTests
//
//  Created by Ata Cenqiz on 17/04/2018.
//  Copyright © 2018 Mobiquity Inc. All rights reserved.
//

import Foundation

class URLSessionDataTaskMock: URLSessionDataTask {
	private let closure: () -> Void
	
	init(closure: @escaping () -> Void) {
		self.closure = closure
	}

	override func resume() {
		closure()
	}
}
