// 
//  CatalogViewModel.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation
import CoreLocation

class CatalogViewModel: ObservableObject {
    static let shared = CatalogViewModel()
    
    private let catalogUseCase = DefaultCatalogUseCase()
    private let locationManager = LocationManager()
    private let urlManager = URLSharingManager.shared
    static private let profileUseCase = DefaultProfileUseCase()
    
    private var minLat: Double = 0
    private var maxLat: Double = 0
    private var minLong: Double = 0
    private var maxLong: Double = 0
    
    var catalogItems = [CatalogItemEntity]()
    @Published var filteredItems = [CatalogItemEntity]()
    @Published var isButtonDisabled = true
    @Published var isLocationAllowed = true
    @Published var catalogState: CatalogState = .initial
    
    init() {
        self.isLocationAllowed = locationManager.checkAuthorization()
        
        Task {
            await fetchCatalog()
            checkCatalogStatus()
            checkUploadButtonStatus()
        }
    }
    
    func fetchCatalog() async {
        let ownerLocation = CLLocation(latitude: LocalUserDefaultRepository.shared.fetch()?.latitude ?? 0, longitude: LocalUserDefaultRepository.shared.fetch()?.longitude ?? 0)
        
        let result = await locationManager.calculateRadius(location: ownerLocation)
        minLat = result.minLatitude ?? 0
        maxLat = result.maxLatitude ?? 0
        minLong = result.minLongitude ?? 0
        maxLong = result.maxLongitude ?? 0
        
        var bulks = await catalogUseCase.fetchCatalogItems(minLat: minLat, maxLat: maxLat, minLon: minLong, maxLon: maxLong)
        
        if bulks.count <= 30 {
            bulks = await catalogUseCase.fetchCatalogItems(minLat: -90, maxLat: 90, minLon: -180, maxLon: 180)
        }
        
        for index in 0..<bulks.count {
            bulks[index].distance = locationManager.calculateDistance(userLocation: ownerLocation, otherUserLocation: CLLocation(latitude: bulks[index].owner.coordinate.lat, longitude: bulks[index].owner.coordinate.lon))
        }
        
        self.catalogItems = bulks
        filterCatalogItems(filter: [])
    }
    
    func checkCatalogStatus() {
        DispatchQueue.main.async {
            if self.catalogItems.isEmpty {
                self.catalogState = .catalogEmpty
            } else if self.filteredItems.isEmpty {
                self.catalogState = .filterCombinationNotFound
            } else if !self.locationManager.checkAuthorization() {
                self.catalogState = .locationNotAllowed
            } else {
                self.catalogState = .normal
                self.isLocationAllowed = true
            }
        }
    }
    
    func checkUploadButtonStatus() {
        DispatchQueue.main.async {
            if self.catalogItems.isEmpty || !self.isLocationAllowed {
                self.isButtonDisabled = true
            } else {
                self.isButtonDisabled = false
            }
        }
    }
    
    func filterCatalogItems(filter: Set<ClothType>) {
        if filter.isEmpty {
            DispatchQueue.main.async {
                self.filteredItems = self.catalogItems
                self.checkCatalogStatus()
            }
        } else {
            DispatchQueue.main.async {
                self.filteredItems = self.catalogItems.filter { item in
                    let categories = Set(item.category)
                    let selected = filter
                    return categories.isSuperset(of: selected)
                }
                
                self.checkCatalogStatus()
            }
        }
    }
    
    func filterItemByOwner(ownerID: String?) -> [CatalogItemEntity] {
        guard let id = ownerID else {
            return [CatalogItemEntity]()
        }
        
        var returnedItems = [CatalogItemEntity]()
        
        returnedItems = self.filteredItems.filter { item in
            guard let owner = item.owner.id else {
                return false
            }
            return owner == id
        }
        
        return returnedItems
    }
    
    func chatGiver(phoneNumber: String, message: String) {
        urlManager.chatInWA(phoneNumber: phoneNumber, textMessage: message)
    }
    
    func getShareLink(clothId: String?) -> URL {
        return urlManager.generateShareLink(clothID: clothId)
    }
    
    func bookmarkItem(clothID: String?) {
        guard let id = clothID else {
            print("No cloth ID")
            return
        }
        
        let result = catalogUseCase.addBookmark(bookmark: id)
        print(result)
    }
    
    func unBookmarkItem(clothID: String?) {
        guard let id = clothID else {
            print("No cloth ID")
            return
        }
        
        let result = catalogUseCase.removeBookmark(bookmark: id)
        print(result)
    }
    
    static func checkIsOwner(ownerId: String?) -> Bool {
        guard let id = ownerId else {
            print("No cloth ID")
            return false
        }
        
        var user = LocalUserEntity(username: "", contactInfo: "", coordinate: (0.0, 0.0))
        
        do {
             user = try profileUseCase.fetchSelfUser()
        } catch {
            print("\(error.localizedDescription)")
        }
        
        guard let userID = user.userID else {
            return false
        }
        
        return userID == id
    }
}


