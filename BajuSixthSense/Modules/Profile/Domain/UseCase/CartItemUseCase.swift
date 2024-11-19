//
//  CartItemUseCase.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 15/11/24.
//

import Foundation
import Combine

protocol CartUseCaseProtocol {
    func fetchCartItem() -> CartData
    func updateCartItem(item: CartData) throws
    func emptyCart() throws
}

final class CartUseCase: CartUseCaseProtocol {
    let cartRepo = CatalogCartRepository.shared
    let clothRepo = ClothRepository.shared
    
    func fetchCartItem() -> CartData {
        guard let data = cartRepo.fecthCart() else {
            return CartData()
        }
        
        return data
    }
    
    func updateCartItem(item: CartData) throws {
        do {
            try cartRepo.saveCart(cart: item)
        } catch {
            throw ActionFailure.FailedAction
        }
    }
    
    func emptyCart() throws {
        do {
            try cartRepo.removeCart()
        } catch {
            throw ActionFailure.FailedAction
        }
    }
    
    func fetchCloths(clothIds: [String]) -> AnyPublisher<[ClothEntity]?, any Error> {
        return Future<[ClothEntity]?, Error> { promise in
            Task {
                let clothes: [ClothEntity] = await withCheckedContinuation { continuation in
                    self.clothRepo.fetchBySelection(ids: clothIds) { returnClothes in
                        guard let retrievedClothes = returnClothes else {
                            continuation.resume(returning: [ClothEntity]())
                            return
                        }
                        
                        continuation.resume(returning: retrievedClothes)
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
