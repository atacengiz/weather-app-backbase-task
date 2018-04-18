//
//  SettingViewController.swift
//  WeatherApp
//
//  Created by Ata Cenqiz on 18/04/2018.
//  Copyright © 2018 Mobiquity Inc. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
	
	@IBOutlet private weak var segmentedControl: UISegmentedControl!
	
	private var presenter: SettingsPresenter?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		presenter = SettingsPresenter(userDefaultsHelper: UserDefaultsHelperImplementation())
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		showPreferedUnit()
	}
	
	private func showPreferedUnit() {
		guard let presenter = presenter else { return }
		let unit = presenter.getPreferredUnit()
		switch unit {
		case .celcius:
			segmentedControl.selectedSegmentIndex = 0
		case .fahrenheit:
			segmentedControl.selectedSegmentIndex = 1
		}
	}
	
	@IBAction func segmentedValueChanged(sender: UISegmentedControl) {
		guard let presenter = presenter else { return }

		switch sender.selectedSegmentIndex {
		case 0:
			presenter.setPreferedUnit(unit: .celcius)
		case 1:
			presenter.setPreferedUnit(unit: .fahrenheit)
		default:
			break
		}
	}
}
