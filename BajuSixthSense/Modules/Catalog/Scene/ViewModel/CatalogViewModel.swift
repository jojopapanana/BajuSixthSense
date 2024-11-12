// 
//  CatalogViewModel.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation
import Combine
import CoreLocation

class CatalogViewModel: ObservableObject {
    static let shared = CatalogViewModel()
    
    private let catalogUseCase = DefaultCatalogUseCase()
    private let locationManager = LocationManager()
    private let urlManager = URLSharingManager.shared
    static private let profileUseCase = DefaultProfileUseCase()
    private var cancelables = [AnyCancellable]()
    
    private var viewDidLoad = PassthroughSubject<Void, Never>()
    private var catalogItems: DataState<[CatalogDisplayEntity]> = .Initial
    @Published var displayCatalogItems: DataState<[CatalogDisplayEntity]> = .Initial
    @Published var isButtonDisabled = true
    @Published var isLocationAllowed = true
    @Published var catalogState: CatalogState = .initial
    
    init() {
        self.isLocationAllowed = locationManager.checkAuthorization()
        fetchCatalogItems()
    }
    
    func fetchCatalogItems() {
        let userSelfLocation = CLLocation(latitude: LocalUserDefaultRepository.shared.fetch()?.latitude ?? 0, longitude: LocalUserDefaultRepository.shared.fetch()?.longitude ?? 0)
        
        let result = self.locationManager.calculateRadius(location: userSelfLocation)
        let minLat = result.minLatitude ?? 0
        let maxLat = result.maxLatitude ?? 0
        let minLon = result.minLongitude ?? 0
        let maxLon = result.maxLongitude ?? 0
        
        fetchCatalogData(minLat: minLat, maxLat: maxLat, minLon: minLon, maxLon: maxLon)
    }
    
    func fetchCatalogData(
        minLat: Double, maxLat: Double, minLon: Double, maxLon: Double
    ) {
        viewDidLoad
            .receive(on: DispatchQueue.global())
            .flatMap {
                return self.catalogUseCase.fetchCatalogItems(
                    minLat: minLat, maxLat: maxLat, minLon: minLon, maxLon: maxLon
                )
                .map { Result.success($0 ?? [CatalogDisplayEntity]()) }
                .catch { Just(Result.failure($0)) }
                .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] resultValue in
                guard let self else { return }
                
                switch resultValue {
                case .success(let catalogs):
                    let data = mapNewlyRetrievedData(catalogs: catalogs)
                    self.catalogItems = .Success(data)
                    self.displayCatalogItems = .Success(data)
                case .failure(let error):
                    self.catalogItems = .Failure(error)
                    self.displayCatalogItems = .Failure(error)
                }
            }
            .store(in: &cancelables)
    }
    
    func checkRetrievedData() {
        if (catalogItems.value?.count ?? 0) < 30 {
            fetchCatalogData(minLat: -90, maxLat: 90, minLon: -180, maxLon: 180)
        }
    }
    
    func mapNewlyRetrievedData(catalogs: [CatalogDisplayEntity]) -> [CatalogDisplayEntity] {
        var returnedCatalogs = self.catalogItems.value ?? [CatalogDisplayEntity]()
        let catalogs = populateCatalogData(catalogs: catalogs)
        
        catalogs.forEach { catalog in
            if !returnedCatalogs.contains(catalog) {
                returnedCatalogs.append(catalog)
            }
        }
        
        return returnedCatalogs
    }
    
    func populateCatalogData(catalogs: [CatalogDisplayEntity]) -> [CatalogDisplayEntity] {
        var returnValue = catalogs
        
        let userSelfLocation = CLLocation(latitude: LocalUserDefaultRepository.shared.fetch()?.latitude ?? 0, longitude: LocalUserDefaultRepository.shared.fetch()?.longitude ?? 0)
        
        for index in 0..<catalogs.count {
            let catalog = catalogs[index]
            let userOtherLocation = CLLocation(
                latitude: catalog.owner.coordinate.lat,
                longitude: catalog.owner.coordinate.lon
            )
            returnValue[index].distance = locationManager.calculateDistance(
                userLocation: userSelfLocation,
                otherUserLocation: userOtherLocation
            )
            
            let minimalPrice = catalog.clothes.min(
                by: { $0.price < $1.price }
            )?.price ?? 0
            
            let maximalPrice = catalog.clothes.max(
                by: { $0.price > $1.price }
            )?.price ?? 0
            
            returnValue[index].lowestPrice = minimalPrice
            returnValue[index].highestPrice = maximalPrice
        }
        
        return returnValue
    }
    
    func checkCatalogStatus() {
//        DispatchQueue.main.async {
//            if self.catalogItems.isEmpty {
//                self.catalogState = .catalogEmpty
//            } else if self.filteredItems.isEmpty {
//                self.catalogState = .filterCombinationNotFound
//            } else if !self.locationManager.checkAuthorization() {
//                self.catalogState = .locationNotAllowed
//            } else {
//                self.catalogState = .normal
//                self.isLocationAllowed = true
//            }
//        }
    }
    
    func checkUploadButtonStatus() {
//        DispatchQueue.main.async {
//            if self.catalogItems.isEmpty || !self.isLocationAllowed {
//                self.isButtonDisabled = true
//            } else {
//                self.isButtonDisabled = false
//            }
//        }
    }
    
    func filterCatalogItems(filter: Set<ClothType>) {
//        if filter.isEmpty {
//            DispatchQueue.main.async {
//                self.filteredItems = self.catalogItems
//                self.checkCatalogStatus()
//            }
//        } else {
//            DispatchQueue.main.async {
//                self.filteredItems = self.catalogItems.filter { item in
//                    let categories = Set(item.category)
//                    let selected = filter
//                    return categories.isSuperset(of: selected)
//                }
//                
//                self.checkCatalogStatus()
//            }
//        }
    }
    
//    func filterItemByOwner(ownerID: String?) -> [CatalogItemEntity] {
//        guard let id = ownerID else {
//            return [CatalogItemEntity]()
//        }
//        
//        var returnedItems = [CatalogItemEntity]()
//        
//        returnedItems = self.filteredItems.filter { item in
//            guard let owner = item.owner.id else {
//                return false
//            }
//            return owner == id
//        }
//        
//        return returnedItems
//    }
    
    func chatGiver(phoneNumber: String, message: String) {
        urlManager.chatInWA(phoneNumber: phoneNumber, textMessage: message)
    }
    
    func getShareLink(clothId: String?) -> URL {
        return urlManager.generateShareClothLink(clothID: clothId)
    }
    
    func addFavorite(owner: String?, cloth: String?) {
        guard let ownerID = owner, let clothID = cloth else { return }
        
        do {
            try catalogUseCase.addFavorite(owner: ownerID, favorite: clothID)
        } catch {
            print("Failed to add favorite: \(error.localizedDescription)")
        }
    }
    
    func removeFavorite(clothID: String?) {
        guard clothID != nil else {
            print("No cloth ID")
            return
        }
    }
    
    static func checkIsOwner(ownerId: String?) -> Bool {
        guard let id = ownerId else {
            print("No cloth ID")
            return false
        }
        
        var user = LocalUserEntity(
            username: "",
            contactInfo: "",
            coordinate: (0.0, 0.0),
            sugestedMinimal: 0
        )
        
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


