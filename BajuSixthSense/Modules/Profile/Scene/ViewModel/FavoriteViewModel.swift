//
//  BookmarkViewModel.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 16/10/24.
//

import Foundation
import Combine
import CoreLocation

class FavoriteViewModel: ObservableObject {
    private let favoriteUsecase = DefaultFavoriteUseCase()
    private let profileUsecase = DefaultProfileUseCase()
    private let locationManager = LocationManager()
    private var cancelabels = [AnyCancellable]()
    
    private let viewDidLoad = PassthroughSubject<Void, Never>()
    @Published var favoriteCatalogs: DataState<[CatalogDisplayEntity]> = .Initial
    
    init() {
        fetchFavoriteCatalog()
        viewDidLoad.send()
    }
    
    deinit {
        cancelabels.forEach { $0.cancel()}
        cancelabels.removeAll()
    }
    
    func fetchFavoriteCatalog() {
        viewDidLoad
            .receive(on: DispatchQueue.global())
            .flatMap {
                return self.favoriteUsecase.fetchBookmarkedClothes()
                    .map { Result.success($0 ?? [CatalogDisplayEntity]()) }
                    .catch { Just(Result.failure($0)) }
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] resultValue in
                guard let self else { return }
                
                switch resultValue {
                    case .success(let value):
                        let data = populateDistanceData(favorites: value)
                        self.favoriteCatalogs = .Success(data)
                    case .failure(let error):
                        self.favoriteCatalogs = .Failure(error)
                }
            }
            .store(in: &cancelabels)
    }
    
    func removeFavorite(owner: String?, cloth: String?) throws {
        guard
            let ownerID = owner,
            let clothID = cloth
        else {
            throw ActionFailure.NilStringError
        }
        
        guard var favoriteClothes = favoriteCatalogs.value else {
            throw ActionFailure.NoDataFound
        }
        
        guard
            let itemIdx = favoriteClothes.firstIndex(
                where: {
                    guard let id = $0.owner.userID else { return false }
                    return ownerID == id
                }) else {
            throw ActionFailure.NoDataFound
        }
        
        guard
            let clothIdx = favoriteClothes[itemIdx].clothes.firstIndex(
                where: {
                    guard let id = $0.id else { return false }
                    return clothID == id
                }) else {
            throw ActionFailure.NoDataFound
        }
        
        favoriteClothes[itemIdx].clothes.remove(at: clothIdx)
        
        self.favoriteCatalogs = .Success(favoriteClothes)
        
        do {
            try favoriteUsecase.removeFavorite(owner: ownerID, favorite: clothID)
        } catch {
            throw ActionFailure.FailedAction
        }
    }
    
    func generateCartData(owner: String?) throws -> CatalogDisplayEntity {
        guard let ownerID = owner else {
            throw ActionFailure.NilStringError
        }
        
        guard let favoriteClothes = favoriteCatalogs.value else {
            throw ActionFailure.NoDataFound
        }
        
        guard
            let itemIdx = favoriteClothes.firstIndex(
                where: {
                    guard let id = $0.owner.userID else { return false }
                    return ownerID == id
                }) else {
            throw ActionFailure.NoDataFound
        }
        
        return favoriteClothes[itemIdx]
    }
    
    func generateDistance(userLocation: CLLocation) -> Double{
        let distance = locationManager.calculateDistance(userLocation: CLLocation(latitude: LocalUserDefaultRepository.shared.fetch()?.latitude ?? 0, longitude: LocalUserDefaultRepository.shared.fetch()?.longitude ?? 0), otherUserLocation: userLocation)
        
        return distance
    }
    
    func populateDistanceData(favorites: [CatalogDisplayEntity]) -> [CatalogDisplayEntity] {
        var items = favorites
        for index in 0..<items.count {
            items[index].distance = locationManager.calculateDistance(userLocation: CLLocation(latitude: LocalUserDefaultRepository.shared.fetch()?.latitude ?? 0, longitude: LocalUserDefaultRepository.shared.fetch()?.longitude ?? 0), otherUserLocation: CLLocation(latitude: items[index].owner.coordinate.lat, longitude: items[index].owner.coordinate.lon))
        }
        
        return items
    }
}
