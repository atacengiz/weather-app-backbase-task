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
	
	private var selectedLocationCoordinates: CLLocationCoordinate2D?
	private var presenter: HomePresenter = HomePresenterImplementation()
	
	// MARK: UIViewController lifecyle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setMapKitTouchRecognizer()
	}
	
	// MARK: MapKit touch
	private func setMapKitTouchRecognizer() {
		let longTouchRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(HomeViewController.mapKitTouched(gestureRecognizer:)))
		longTouchRecognizer.minimumPressDuration = 0.5
		mapView.addGestureRecognizer(longTouchRecognizer)
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
		let presenter = CityInformationPresenterImplementation(currentWeatherDataService: CurrentWeatherDataServiceImplementation())
		presenter.viewController = viewController
		
		viewController.presenter = presenter
		viewController.coordinates = coordinates
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
