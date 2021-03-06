//
//  CityInformationViewController.swift
//  WeatherApp
//
//  Created by Ata Cenqiz on 18/04/2018.
//  Copyright © 2018 Mobiquity Inc. All rights reserved.
//

import UIKit
import MapKit

class CityInformationViewController: UIViewController {
	
	@IBOutlet weak private var loadingView: UIView!
	@IBOutlet weak private var cityNameLabel: UILabel!
	@IBOutlet weak private var tempatureValueLabel: UILabel!
	@IBOutlet weak private var humidityValueLabel: UILabel!
	@IBOutlet weak private var windValueLabel: UILabel!
	@IBOutlet weak private var collectionView: UICollectionView!
	
	var coordinates: CLLocationCoordinate2D?
	var presenter: CityInformationPresenter?
	var weatherConditions = [WeatherConditions]()
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		getWeatherInformation()
	}
	
	// MARK: Public functions
	func showResponse(isSuccess: Bool) {
		if isSuccess {
			loadingView.isHidden = true
		}
		else {
			let alert = UIAlertController(title: "Error", message: "An error occured during network communication", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: { [weak self] _ in
				self?.getWeatherInformation()
			}))
			alert.addAction(UIAlertAction(title: "Back", style: .cancel, handler: { [weak self] _ in
				self?.navigationController?.popViewController(animated: true)
			}))
			alert.show(self, sender: nil)
		}
	}
	
	func show(cityWeatherInformation: CityWeatherInformation, unit: String) {
		cityNameLabel.text = cityWeatherInformation.name
		tempatureValueLabel.text = "\(String(format: "%.2f", cityWeatherInformation.tempature.current)) \(unit)"
		humidityValueLabel.text = "\(cityWeatherInformation.tempature.humidity)"
		windValueLabel.text = "\(String(format: "%.2f", cityWeatherInformation.wind.speed))"
		
		weatherConditions = cityWeatherInformation.weather
		collectionView.reloadData()
	}
	
	// MARK: Private functions
	private func getWeatherInformation() {
		guard let coordinates = coordinates, let presenter = presenter else {
			print("Cannot continue flow without coordinate or presenter")
			navigationController?.popViewController(animated: true)
			return
		}
		
		loadingView.isHidden = false
		presenter.getWeatherData(longitude: coordinates.longitude, latitude: coordinates.latitude)
	}
}

extension CityInformationViewController: UICollectionViewDataSource {
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return weatherConditions.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let identifier = "CityInformationCollectionViewCell"
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
		
		if let cell = cell as? CityInformationCollectionViewCell {
			cell.set(weatherDescription: weatherConditions[indexPath.row].description, iconName: weatherConditions[indexPath.row].icon)
		}
		
		return cell
	}
}
