//
//  LocationManager.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 13/10/24.
//

import Foundation
import CoreLocation
import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate{
    let manager = CLLocationManager()
    @Published var addressName: String?
    @Published var authorizationStatus: Bool?
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func checkAuthorization() {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        default:
            return
        }
    }
    
    private var continuation: CheckedContinuation<CLLocation, Error>?
        
    func getCurrentLocation() async throws -> CLLocation {
        return try await withCheckedThrowingContinuation { continuation in
            self.continuation = continuation
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        if let lastLocation = locations.last {
            continuation?.resume(returning: lastLocation)
            continuation = nil
        }
        
//        lookUpCurrentLocation { placemark in
//            self.addressName = placemark
//        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        continuation?.resume(throwing: error)
        continuation = nil
    }
    
    func lookUpCurrentLocation(location: CLLocation) async -> String? {
        var regionDescription = ""
        let geocoder = CLGeocoder()
        
        do {
            let placemarks = try await geocoder.reverseGeocodeLocation(location)
            if let firstLocation = placemarks.first {
                regionDescription = "\(firstLocation.locality ?? "Unknown"), \(firstLocation.administrativeArea ?? "Unknown")"
            }
        } catch {
            print("error in geocoding")
        }
        
        return regionDescription
    }
    
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        switch manager.authorizationStatus {
//        case .authorizedWhenInUse:
//            authorizationStatus = true
//            break
//            
//        case .restricted, .denied:
//            authorizationStatus = false
//            break
//            
//        case .notDetermined:
//           manager.requestWhenInUseAuthorization()
//            break
//            
//        default:
//            break
//        }
//    }

    
    func calculateRadius(location: CLLocation) async -> (minLatitude:Double?, maxLatitude:Double?, minLongitude:Double?, maxLongitude:Double?){
        let radius: CLLocationDistance = 10000
        let latitudinalDelta = radius / 111000
        let longitudinalDelta = radius / (111000 * cos(location.coordinate.latitude * .pi / 180))

        let maxLatitude = location.coordinate.latitude + latitudinalDelta
        let minLatitude = location.coordinate.latitude - latitudinalDelta
        let maxLongitude = location.coordinate.longitude + longitudinalDelta
        let minLongitude = location.coordinate.longitude - longitudinalDelta
        
        return (minLatitude, maxLatitude, minLongitude, maxLongitude)
    }
    
    func calculateDistance(userLocation: CLLocation, otherUserLocation: CLLocation) -> CLLocationDistance {
        let distance = userLocation.distance(from: otherUserLocation)
        
        return distance
    }
}
