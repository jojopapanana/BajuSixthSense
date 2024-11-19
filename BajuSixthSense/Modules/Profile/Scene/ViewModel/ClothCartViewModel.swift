//
//  ClothCartViewModel.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 15/11/24.
//

import Foundation
import Combine

class ClothCartViewModel: ObservableObject {
    var catalogCart = CartData()
    private let cartUseCase = CartUseCase()
    private var cancelables = [AnyCancellable]()
    
    private var viewDidLoad = PassthroughSubject<Void, Never>()
    @Published var clothEntities: DataState<[ClothEntity]> = .Initial
    
    init() {
        fetchCatalogCart()
        fetchCartItems()
        viewDidLoad.send()
    }
    
    deinit {
        cancelables.forEach { $0.cancel() }
        cancelables.removeAll()
    }
    
    func fetchCartItems() {
        if catalogCart.clothItems.isEmpty {
            return
        }
        let ids = catalogCart.clothItems
        
        viewDidLoad
            .receive(on: DispatchQueue.global())
            .flatMap {
                return self.cartUseCase.fetchCloths(clothIds: ids)
                    .map { Result.success($0 ?? [ClothEntity]()) }
                    .catch { Just(Result.failure($0)) }
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                guard let self else { return }
                
                switch result {
                case .success(let clothes):
                    self.clothEntities = .Success(clothes)
                case .failure(let error):
                    self.clothEntities = .Failure(error)
                }
            }
            .store(in: &cancelables)
    }
    
    func fetchCatalogCart() {
        self.catalogCart = cartUseCase.fetchCartItem()
    }
    
    func updateCatalogCart(cloth: ClothEntity) throws {
        var data = self.catalogCart
        
        if !data.clothOwner.userID.isEmpty && !data.clothOwner.contact.isEmpty {
            if data.clothOwner.userID == cloth.owner {
                data.clothItems.append(cloth.id ?? "")
            } else {
                try emptyCurrCart()
            }
        }
        
        do {
            try cartUseCase.updateCartItem(item: data)
        } catch {
            throw ActionFailure.FailedAction
        }
    }
    
    func emptyCurrCart() throws {
        do {
            try cartUseCase.emptyCart()
        } catch {
            throw ActionFailure.FailedAction
        }
    }
    
    func removeCartItem(cloth: ClothEntity) {
        guard
            var data = self.clothEntities.value,
            let idx = data.firstIndex(of: cloth)
        else { return }
        
        data.remove(at: idx)
        self.clothEntities = .Success(data)
    }
    
    func getFirstCharacter() -> String {
        guard let initial = self.catalogCart.clothOwner.username.uppercased().first else {
            return "?"
        }
        
        return String(initial)
    }
    
    func getUsername() -> String {
        return self.catalogCart.clothOwner.username
    }
    
    func getDistance() -> String {
        #warning("calculate the distance here")
        
        return "??"
    }
    
    func getRecommended() -> String {
        return String(self.catalogCart.clothOwner.sugestedAmount)
    }
    
    func getContactInfo() -> String {
        return self.catalogCart.clothOwner.contact
    }
}
