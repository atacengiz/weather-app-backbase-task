//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by Ata Cenqiz on 18/04/2018.
//  Copyright © 2018 Mobiquity Inc. All rights reserved.
//

import UIKit
import MapKit

class HomeViewController: UIViewController {
	
	// MARK: Private variables
	@IBOutlet weak private var mapView: MKMapView!
	@IBOutlet weak private var tableView: UITableView!
	
	private var selectedLocationCoordinates: CLLocationCoordinate2D?
	private var presenter: HomePresenter?
	private var storedCities: [CityWeatherInformation]?
	
	// MARK: UIViewController lifecyle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setPresenter()
		setMapKitTouchRecognizer()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		presenter?.showStoredCities()
	}
	
	private func setPresenter() {
		presenter = HomePresenterImplementation(cityWeatherPersistanceHelper: CityWeatherPersistanceHelperImplementation(userDefaultsHelper: UserDefaultsHelperImplementation()), viewController: self)
	}
	
	// MARK: MapKit touch
	private func setMapKitTouchRecognizer() {
		let longTouchRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(HomeViewController.mapKitTouched(gestureRecognizer:)))
		longTouchRecognizer.minimumPressDuration = 0.5
		mapView.addGestureRecognizer(longTouchRecognizer)
	}
	
	func updateStoredCities(cities: [CityWeatherInformation]) {
		storedCities = cities
		tableView.reloadData()
	}
	
	@objc
	func mapKitTouched(gestureRecognizer: UIGestureRecognizer) {
		if gestureRecognizer.state != .began { return }
		
		let touchPoint = gestureRecognizer.location(in: mapView)
		let touchMapCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)

		let annotation = MKPointAnnotation()
		annotation.coordinate = touchMapCoordinate
		annotation.title = "Touch for search"
		annotation.subtitle = "lon: \(touchMapCoordinate.longitude), lat: \(touchMapCoordinate.latitude)"
		
		mapView.addAnnotation(annotation)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let coordinates = selectedLocationCoordinates, let viewController = segue.destination as? CityInformationViewController, segue.identifier == "segueToCityInformation" else { return }
		let presenter = CityInformationPresenterImplementation(currentWeatherDataService: CurrentWeatherDataServiceImplementation(), cityWeatherPersistanceHelper: CityWeatherPersistanceHelperImplementation(userDefaultsHelper: UserDefaultsHelperImplementation()))
		presenter.viewController = viewController
		
		viewController.presenter = presenter
		viewController.coordinates = coordinates
	}
}

// MARK: UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let storedCities = storedCities else { return 1 }
		return storedCities.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "homeTableViewCell", for: indexPath)
		
		if let cell = cell as? HomeTableViewCell {
			if let storedCities = storedCities {
				cell.setCity(name: storedCities[indexPath.row].name)
			}
			else {
				cell.setCity(name: "Please select a location to search")
			}
		}
		
		return cell
	}
}

// MARK: UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		guard let storedCities = storedCities else { return }
		let selectedCity = storedCities[indexPath.row]
		let coordinate = CLLocationCoordinate2D(latitude: selectedCity.coord.lat, longitude: selectedCity.coord.lon)
		selectedLocationCoordinates = coordinate
		performSegue(withIdentifier: "segueToCityInformation", sender: nil)
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if let storedCities = storedCities, editingStyle == .delete {
			presenter?.removeCity(cityInfo: storedCities[indexPath.row])
			self.storedCities?.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .fade)
		}
	}
}

// MARK: MKMapViewDelegate
extension HomeViewController: MKMapViewDelegate {
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		let identifier = "mapKitLocationPin"
		
		let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
		annotationView.canShowCallout = true
		annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
		
		return annotationView
	}
	
	func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
		guard let annotation = view.annotation else { return }
		selectedLocationCoordinates = annotation.coordinate
		performSegue(withIdentifier: "segueToCityInformation", sender: nil)
	}
}
