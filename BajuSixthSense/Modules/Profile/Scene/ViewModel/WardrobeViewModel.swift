//
//  WardrobeViewModel.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 16/10/24.
//

import Foundation
import Combine

class WardrobeViewModel: ObservableObject {
    private let wardrobeUseCase = DefaultWardrobeUseCase()
    private let bookmarkUseCase = DefaultFavoriteUseCase()
    private let profileUseCase = DefaultProfileUseCase()
    private var cancelables = [AnyCancellable]()
    
    private let viewDidLoad = PassthroughSubject<Void, Never>()
    @Published var wardrobeItems: DataState<[ClothEntity]> = . Initial
    
    init() {
        fetchSelfWardrobe()
    }
    
    init(id: String) {
        fetchOthersWardrobe(id: id)
    }
    
    deinit {
        cancelables.forEach { $0.cancel() }
        cancelables.removeAll()
    }
    
    func fetchSelfWardrobe() {
        viewDidLoad
            .receive(on: DispatchQueue.global())
            .flatMap {
                return self.wardrobeUseCase.fetchWardrobe()
                    .map { Result.success($0 ?? [ClothEntity]()) }
                    .catch { Just(Result.failure($0)) }
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] resultValue in
                guard let self else { return }
                
                switch resultValue {
                    case .success(let value):
                        self.wardrobeItems = .Success(value)
                    case .failure(let error):
                        self.wardrobeItems = .Failure(error)
                }
            }
            .store(in: &cancelables)
    }
    
    func fetchOthersWardrobe(id: String) {
        viewDidLoad
            .receive(on: DispatchQueue.global())
            .flatMap {
                return self.wardrobeUseCase.getOtherUserWardrobe(userID: id)
                    .map { Result.success($0 ?? [ClothEntity]()) }
                    .catch { Just(Result.failure($0)) }
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] resultValue in
                guard let self else { return }
                
                switch resultValue {
                    case .success(let value):
                        let data = mapSavedClothes(clothes: value, owner: id)
                        self.wardrobeItems = .Success(data)
                    case .failure(let error):
                        self.wardrobeItems = .Failure(error)
                }
            }
            .store(in: &cancelables)
    }
    
    func mapSavedClothes(clothes: [ClothEntity], owner: String) -> [ClothEntity] {
        var returnedClothes = [ClothEntity]()
        let selfUser = profileUseCase.fetchSelfData()
        guard
            let dataIdx = selfUser.favorite.firstIndex(where: { $0.userID == owner })
        else { return clothes }
        
        let favorites = selfUser.favorite[dataIdx].savedClothes
        
        for cloth in clothes {
            guard let id = cloth.id else { continue }
            if favorites.contains(id) {
                returnedClothes.insert(cloth, at: 0)
            } else {
                returnedClothes.append(cloth)
            }
        }
        
        return returnedClothes
    }
    
    func removeWardrobe(id: String?) throws {
        guard let clothID = id else {
            throw ActionFailure.FailedAction
        }
        
        Task {
            do { try await wardrobeUseCase.deleteCloth(clothID: clothID) }
            catch {
                throw ActionFailure.FailedAction
            }
        }
        
        guard
            var items = self.wardrobeItems.value,
            let index = items.firstIndex(where: { $0.id == clothID })
        else {
            throw ActionFailure.NoDataFound
        }
        
        items.remove(at: index)
        
        wardrobeItems = .Success(items)
    }
    
    func updateWardrobe(cloth: ClothEntity) throws {
        Task {
            do { try await wardrobeUseCase.editCloth(cloth: cloth) }
            catch {
                throw ActionFailure.FailedAction
            }
        }
        
        guard
            var items = self.wardrobeItems.value,
            let index = items.firstIndex(where: { $0.id == cloth.id })
        else {
            throw ActionFailure.NoDataFound
        }
        
        items[index] = cloth
        wardrobeItems = .Success(items)
    }
    
    func updateClothStatus(clothId: String?, status: ClothStatus) throws {
        Task {
            guard let id = clothId else {
                throw ActionFailure.FailedAction
            }
            do {
                try await wardrobeUseCase.editClothStatus(clothID: id, clothStatus: status)
            } catch {
                throw ActionFailure.FailedAction
            }
        }
        
        guard
            var items = self.wardrobeItems.value,
            let id = clothId,
            let index = items.firstIndex(where: { $0.id == id })
        else {
            throw ActionFailure.NoDataFound
        }
        
        items[index].status = status
        wardrobeItems = .Success(items)
    }
    
//    func mapCatalogItemSelf(cloth: ClothEntity) -> CatalogItemEntity {
//        var user: UserEntity
//        
//        do {
//            let selfUser = try profileUseCase.fetchSelfUser()
//            user = selfUser.mapToUser()
//        } catch {
//            user = UserEntity(userID: "", username: "", contactInfo: "", coordinate: (0.0, 0.0), wardrobe: [])
//        }
//        
//        return CatalogItemEntity.mapEntitty(cloth: cloth, owner: user)
//    }
    
//    func getItems(status: ClothStatus) -> [ClothEntity] {
//        return status == .Initial ? self.draftItems : self.postedItems
//    }
}
