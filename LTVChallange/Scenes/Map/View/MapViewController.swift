//
//  MapViewController.swift
//  LTVChallange
//
//  Created by Josue German Hernandez Gonzalez on 09-12-21.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    // MARK: - Properties
    
    private let mapView = MKMapView()
    private let searchVC = UISearchController(searchResultsController: SearchViewController())
    private var viewModel: MapViewModel!
    
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MapViewModel(with: mapView)
        
        configNavigationBar()
        view.addSubview(mapView)
        searchVC.searchResultsUpdater = self
        
        navigationItem.searchController = searchVC
        
        mapView.showsUserLocation = true
        viewModel.locationManager!.delegate = self
        viewModel.locationManager!.requestWhenInUseAuthorization()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.frame = CGRect(x: 0,
                               y: view.safeAreaInsets.top,
                               width: view.frame.size.width,
                               height: view.frame.size.height - view.safeAreaInsets.top)
    }
    
    
    // MARK: - Methods
    
    func configNavigationBar() {
        title = "Map"
        guard let navigationController = navigationController else { return }
        navigationController.navigationBar.prefersLargeTitles = true
        
    }
    
}


extension MapViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              let resultVC = searchController.searchResultsController as? SearchViewController else {
                  return
              }
        
        resultVC.delegate = self
        
        viewModel.findPlaces(quey: query) { result in
            switch result {
            case .success(let places):
                DispatchQueue.main.async {
                    resultVC.update(with: places)
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
}


extension MapViewController: SearchViewControllerDelegate {
    func didTapPlace(with coordinates: CLLocationCoordinate2D) {
        searchVC.searchBar.resignFirstResponder()
        searchVC.dismiss(animated: true, completion: nil)
        
        mapView.removeAnnotations(mapView.annotations)
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinates
        mapView.addAnnotation(pin)
        mapView.setRegion(MKCoordinateRegion.init(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)), animated: true)
    }
    
}


extension MapViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways {
            self.viewModel.locationManager!.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        self.viewModel.updateLocationOnMap(to: location, with: "string")
    }


}
