//
//  HelpViewController.swift
//  WeatherApp
//
//  Created by Ata Cenqiz on 18/04/2018.
//  Copyright © 2018 Mobiquity Inc. All rights reserved.
//

import UIKit
import WebKit

class HelpViewController: UIViewController {
	
	@IBOutlet private weak var webView: WKWebView!
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		loadPage()
	}
	
	private func loadPage() {
		guard let url = URL(string: HelpPageConstants.url) else { return }
		webView.load(URLRequest(url: url))
	}
}
