//
//  ServiceDirectoryViewModel.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 5/1/24.
//

import SwiftUI
import MapKit


final class ServiceDirectoryViewModel: NSObject, ObservableObject {
    
    let queue = DispatchQueue(label:"myOwnQueue")
    private var locationManager: CLLocationManager?
    @Published var latestUserLocation: CLLocation?
    
    
    //my location: 33.9320091, longitude: -84.4986661
    //Hospital: "lat": 33.85751, "lon": -84.51503,
    @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 33.9320091, longitude: -84.4986661), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    @Published private var visibleRegion: MKCoordinateRegion?
    @Published var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @Published var searchResults: [MKMapItem] = []
    @Published var selectedResult: MKMapItem?
    @Published var route: MKRoute?
    
    
    var binding: Binding<MKCoordinateRegion> {
        Binding {
            self.mapRegion
        } set: { newRegion in
            self.mapRegion = newRegion
        }
    }
    
    func checkIfLocationIsEnabled() {
        
        
        queue.async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager = CLLocationManager()
                self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
                self.locationManager!.delegate = self
                self.locationManager?.requestAlwaysAuthorization()
                self.locationManager?.startUpdatingLocation()
                

                DispatchQueue.main.async {
                    self.latestUserLocation = self.locationManager?.location
                    self.searchHospital()
                }
                
            } else {
                print("Show an alert letting them know this is off")
            }
        }
        

    }
    
    
    
    func searchHospital() {
        search(for: "hospital")
    }
    
    private func search(for query: String) {
        
        guard let latestUserLocation = latestUserLocation else { return }
        
        let request = MKLocalSearch.Request()
        
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        request.region = MKCoordinateRegion (
            center: latestUserLocation.coordinate,
            span: MKCoordinateSpan (latitudeDelta: 0.0125, longitudeDelta: 0.0125))
        
        Task {
            let search = MKLocalSearch (request: request)
            let response = try? await search.start ()
            searchResults = response?.mapItems ?? []
        }
    }
    
    
    func getDirections() {
        route = nil
        guard let selectedResult, let latestUserLocation else { return }
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: latestUserLocation.coordinate))
        request.destination = selectedResult
        
        Task {
            let directions = MKDirections(request: request)
            let response = try? await directions.calculate()
            route = response?.routes.first
        }
    }
    
    func getDistance() -> Double {
        guard let latestUserLocation, let hospitalLocation = selectedResult?.placemark.location  else { return 0}
        return hospitalLocation.distance(from: latestUserLocation)
    }
    
    private func checkLocationAuthorization() {
        guard let location = locationManager else {
            return
        }
        switch location.authorizationStatus {
        case .notDetermined:
            print("Location authorization is not determined.")
        case .restricted:
            print("Location is restricted.")
        case .denied:
            print("Location permission denied.")
        case .authorizedAlways, .authorizedWhenInUse:
            if let location = location.location {
                mapRegion = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
            }
        default:
            break
        }
    }
    
}


extension ServiceDirectoryViewModel: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("locationManagerDidChangeAuthorization: \(manager.authorizationStatus)")
        DispatchQueue.main.async { [self] in
            checkLocationAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations: \(String(describing: locations.last))")

        DispatchQueue.main.async {
            if let location = locations.last {
                self.latestUserLocation = location
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
        // Handle errors
    }
    
}
