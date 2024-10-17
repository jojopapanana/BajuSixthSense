// 
//  CatalogViewModel.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation
import CoreLocation

class CatalogViewModel: ObservableObject{
    private let catalogUseCase = DefaultCatalogUseCase()
    private let locationManager = LocationManager()
    private var minLat: Double = 0
    private var maxLat: Double = 0
    private var minLong: Double = 0
    private var maxLong: Double = 0
    
    func fetchCatalog() async -> [CatalogItemEntity] {
        let ownerLocation = CLLocation(latitude: LocalUserDefaultRepository.shared.fetch()?.latitude ?? 0, longitude: LocalUserDefaultRepository.shared.fetch()?.longitude ?? 0)
        
        let result = await locationManager.calculateRadius(location: ownerLocation)
        minLat = result.minLatitude ?? 0
        maxLat = result.maxLatitude ?? 0
        minLong = result.minLongitude ?? 0
        maxLong = result.maxLongitude ?? 0
        
        var bulks = catalogUseCase.fetchCatalogItems(minLat: minLat, maxLat: maxLat, minLon: minLong, maxLon: maxLong)
        
        for index in 0..<bulks.count {
            bulks[index].distance = locationManager.calculateDistance(userLocation: ownerLocation, otherUserLocation: CLLocation(latitude: bulks[index].owner.coordinate.lat, longitude: bulks[index].owner.coordinate.lon))
        }
        
        if bulks.count <= 30 {
            bulks = catalogUseCase.fetchCatalogItems(minLat: -90, maxLat: 90, minLon: -180, maxLon: 180)
        }
        
        return bulks
    }
    
    func checkCatalogStatus(clothesCount: Int, isResultEmpty: Bool, isLocationAllowed: Bool) -> CatalogState {
        if clothesCount == 0 {
            return .catalogEmpty
        } else if isResultEmpty {
            return .filterCombinationNotFound
        } else if !isLocationAllowed {
            return .locationNotAllowed
        } else {
            return .normal
        }
    }
}


