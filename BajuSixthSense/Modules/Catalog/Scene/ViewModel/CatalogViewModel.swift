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
    
    static private let catalogUseCase = DefaultCatalogUseCase()
    private let locationManager = LocationManager()
    static private let urlManager = URLSharingManager.shared
    static private let profileUseCase = DefaultProfileUseCase()
    private let cartUseCase = CartUseCase()
    private var cancelables = [AnyCancellable]()
    
    private var viewDidLoad = PassthroughSubject<Void, Never>()
    private var catalogItems: DataState<[CatalogDisplayEntity]> = .Initial
    private var enableCheckRetrieved = true
    private var lastFetchedLocation: CLLocation?
    @Published var displayCatalogItems: DataState<[CatalogDisplayEntity]> = .Initial
    @Published var isButtonDisabled = true
    @Published var isLocationAllowed = true
    @Published var catalogState: CatalogState = .initial
    @Published var catalogCart = CartData()
    
    init() {
        Task {
            self.isLocationAllowed = await locationManager.makeLocationRequest()
            fetchCatalogItems()
            fetchCatalogCart()
        }
    }
    
    func updateData() {
        enableCheckRetrieved = true
        fetchCatalogItems()
    }
    
    func fetchCatalogItems() {
        let currentLocation = CLLocation(
            latitude: LocalUserDefaultRepository.shared.fetch()?.latitude ?? 0,
            longitude: LocalUserDefaultRepository.shared.fetch()?.longitude ?? 0
        )
        
        guard currentLocation != lastFetchedLocation else { return }
        lastFetchedLocation = currentLocation
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            let result = self.locationManager.calculateRadius(location: currentLocation)
            let minLat = result.minLatitude ?? 0
            let maxLat = result.maxLatitude ?? 0
            let minLon = result.minLongitude ?? 0
            let maxLon = result.maxLongitude ?? 0
            
            self.fetchCatalogData(minLat: minLat, maxLat: maxLat, minLon: minLon, maxLon: maxLon)
            
            DispatchQueue.main.async {
                self.viewDidLoad.send()
            }
        }
    }
    
    func fetchCatalogData(
        minLat: Double, maxLat: Double, minLon: Double, maxLon: Double
    ) {
        viewDidLoad
            .receive(on: DispatchQueue.global(qos: .background))
            .flatMap {
                return CatalogViewModel.catalogUseCase.fetchCatalogItems(
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
                
                checkCatalogStatus()
                checkUploadButtonStatus()
                checkRetrievedData()
            }
            .store(in: &cancelables)
    }
    
    func checkRetrievedData() {
        if (catalogItems.value?.count ?? 0) < 30 && enableCheckRetrieved {
            enableCheckRetrieved = false
            fetchCatalogData(minLat: -90, maxLat: 90, minLon: -180, maxLon: 180)
            viewDidLoad.send()
        }
    }
    
    func mapNewlyRetrievedData(catalogs: [CatalogDisplayEntity]) -> [CatalogDisplayEntity] {
        var returnedCatalogs = self.catalogItems.value ?? [CatalogDisplayEntity]()
        let catalogs = populateCatalogData(catalogs: catalogs)
        
        catalogs.forEach { catalog in
            if !catalog.clothes.isEmpty && !returnedCatalogs.contains(where: {
                $0.owner.userID == catalog.owner.userID
            }) {
                returnedCatalogs.append(catalog)
            }
        }
        
        return returnedCatalogs.sorted(by: {
            $0.distance ?? 0 < $1.distance ?? 0
        })
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
            returnValue[index].distance = ceil(locationManager.calculateDistance(
                userLocation: userSelfLocation,
                otherUserLocation: userOtherLocation
            ))
            
            let minimalPrice = catalog.clothes.min(
                by: { $0.price < $1.price }
            )?.price ?? 0
            
            let maximalPrice = catalog.clothes.max(
                by: { $0.price < $1.price }
            )?.price ?? 0
            
            returnValue[index].lowestPrice = minimalPrice
            returnValue[index].highestPrice = maximalPrice
        }
        
        return returnValue
    }
    
    func checkCatalogStatus() {
        guard let catalogs = self.catalogItems.value else { return }
        
        if catalogs.isEmpty {
            self.catalogState = .catalogEmpty
        } else if !self.locationManager.checkAuthorization() {
            self.catalogState = .locationNotAllowed
        } else {
            self.catalogState = .normal
            self.isLocationAllowed = true
        }
    }
    
    func checkUploadButtonStatus() {
        if self.catalogState == .normal {
            self.isButtonDisabled = false
        } else {
            self.isButtonDisabled = true
        }
    }
    
    func chatGiver(phoneNumber: String, message: String) {
        CatalogViewModel.urlManager.chatInWA(phoneNumber: phoneNumber, textMessage: message)
    }
    
    static func getShareLink(clothId: String?) -> URL {
        return urlManager.generateShareClothLink(clothID: clothId)
    }
    
    static func addFavorite(owner: String?, cloth: String?) {
        guard let ownerID = owner, let clothID = cloth else { return }
        
        do {
            try catalogUseCase.addFavorite(owner: ownerID, favorite: clothID)
        } catch {
            print("Failed to add favorite: \(error.localizedDescription)")
        }
    }
    
    static func removeFavorite(owner: String?, cloth: String?) {
        guard let ownerID = owner, let clothID = cloth else { return }
        
        do {
            try catalogUseCase.removeFavorite(owner: ownerID, favorite: clothID)
        } catch {
            print("Failed to remove favorite: \(error.localizedDescription)")
        }    }
    
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
    
    func fetchCatalogCart() {
        self.catalogCart = cartUseCase.fetchCartItem()
    }
    
    func checkCartIsEmpty() -> Bool {
        let checkUser = self.catalogCart.clothOwner.userID.isEmpty && self.catalogCart.clothOwner.username.isEmpty
        let checkClothes = self.catalogCart.clothItems.isEmpty
        
        return checkUser && checkClothes
    }
    
    static func fetchClothData(clothId: String) async -> ClothEntity {
        guard let cloth = await catalogUseCase.fetchCloth(id: clothId) else {
            return ClothEntity()
        }
        
        return cloth
    }
    
    func filterCatalogItems(minPrice: Double, maxPrice: Double) {
        print("minprice: \(minPrice) maxprice: \(maxPrice)")
        
        switch catalogItems {
        case .Initial, .Loading:
            displayCatalogItems = .Initial
        case .Failure(let errorMessage):
            displayCatalogItems = .Failure(errorMessage)
        case .Success(let items):
            displayCatalogItems = .Initial
            
            let filteredItems = items.filter { item in
                Double(item.lowestPrice ?? 0) >= minPrice && Double(item.highestPrice ?? 0) <= maxPrice
            }
            displayCatalogItems = .Success(filteredItems)
        }
    }
}


