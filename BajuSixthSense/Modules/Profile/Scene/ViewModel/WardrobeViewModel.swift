//
//  WardrobeViewModel.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 16/10/24.
//

import Foundation
import Combine

class WardrobeViewModel: ObservableObject {
    static let shared = WardrobeViewModel()
    private let wardrobeUseCase = DefaultWardrobeUseCase()
    private let bookmarkUseCase = DefaultFavoriteUseCase()
    private let profileUseCase = DefaultProfileUseCase()
    private var cancelables = [AnyCancellable]()
    
    private let viewDidLoad = PassthroughSubject<Void, Never>()
    @Published var wardrobeItems = [ClothEntity]()
    
    init() {
        fetchSelfWardrobe()
        viewDidLoad.send()
    }
    
    init(id: String) {
        fetchOthersWardrobe(id: id)
        viewDidLoad.send()
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
                        self.wardrobeItems = value
                    case .failure(let error):
                        print("failed to fetch wardrobe: \(error)")
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
                        self.wardrobeItems = data
                    case .failure(let error):
                        print("failed to fetch wardrobe: \(error)")
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
            let index = wardrobeItems.firstIndex(where: { $0.id == clothID })
        else {
            throw ActionFailure.NoDataFound
        }
        
        wardrobeItems.remove(at: index)
    }
    
    func updateWardrobe(cloth: ClothEntity) throws {
        Task {
            do { try await wardrobeUseCase.editCloth(cloth: cloth) }
            catch {
                throw ActionFailure.FailedAction
            }
        }
        
        guard
            let index = wardrobeItems.firstIndex(where: { $0.id == cloth.id })
        else {
            throw ActionFailure.NoDataFound
        }
        
        wardrobeItems[index] = cloth
    }
    
    func updateClothesStatuses(clothes: [ClothEntity]) {
        for cloth in clothes {
            let id = cloth.id
            let status = cloth.status == ClothStatus.Posted ? ClothStatus.Given : ClothStatus.Posted
            
            do {
                try updateClothStatus(clothId: id, status: status)
            } catch {
                print("Failed to update cloth status: \(error.localizedDescription)")
            }
        }
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
            let id = clothId,
            let index = wardrobeItems.firstIndex(where: { $0.id == id })
        else {
            throw ActionFailure.NoDataFound
        }
        
        wardrobeItems[index].status = status
    }
    
    func fetchWardrobeItems() -> [ClothEntity] {
        return wardrobeItems
    }
}
