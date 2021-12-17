//
//  MapViewModel.swift
//  LTVChallange
//
//  Created by Josue German Hernandez Gonzalez on 13-12-21.
//

import Foundation
import GooglePlaces
import MapKit

final class MapViewModel {

    private let client = GMSPlacesClient.shared()
    private var mapView: MKMapView!
    var locationManager: CLLocationManager?
    
    enum PlaceError: Error {
        case failedToFind
        case failedToGetCoordinate
    }
    
    public init(with mapView: MKMapView) {
        self.mapView = mapView
        let manager = CLLocationManager()
        manager.distanceFilter = 15
        manager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager = manager
    }

    public init?() { }
    
    
    public func findPlaces(quey: String, completion: @escaping (Result<[Place], Error>) -> Void) {
        let filter = GMSAutocompleteFilter()
        filter.type = .geocode
        client.findAutocompletePredictions(fromQuery: quey,
                                           filter: filter,
                                           sessionToken: nil) { results, error in
            guard let results = results, error == nil else {
                completion(.failure(PlaceError.failedToFind))
                return
            }
            
            let places: [Place] = results.compactMap({
                Place(name: $0.attributedFullText.string,
                      id: $0.placeID)
            })
            completion(.success(places))
        }
    }
    
    public func resolveLocation(for place: Place, completion: @escaping (Result<CLLocationCoordinate2D, Error>) -> Void) {
        client.fetchPlace(fromPlaceID: place.id,
                          placeFields: .coordinate,
                          sessionToken: nil) { googlePlace, error in
            
            guard let googlePlace = googlePlace, error == nil else {
                completion(.failure(PlaceError.failedToGetCoordinate))
                return
            }
            
            let coordinate = CLLocationCoordinate2D(latitude: googlePlace.coordinate.latitude,
                                                    longitude: googlePlace.coordinate.longitude)
            completion(.success(coordinate))
        }
    }
    
    
    func updateLocationOnMap(to location: CLLocation, with title: String?) {
        let viewRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        self.mapView.setRegion(viewRegion, animated: true)
    }
    
    func centerLocation() {
        let coordinate = self.mapView.userLocation.coordinate
        let center = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapView.setRegion(region, animated: true)
    }
    
}
