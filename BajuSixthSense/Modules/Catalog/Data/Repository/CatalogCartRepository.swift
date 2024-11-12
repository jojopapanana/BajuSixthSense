//
//  CatalogCartRepository.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 12/11/24.
//

import Foundation

protocol CatalogCartRepoProtocol {
    func saveCart(cart: CartData) throws
    func fecthCart() -> CartData?
    func removeCart(cart: CartData) throws
}

final class CatalogCartRepository: CatalogCartRepoProtocol {
    static let shared = CatalogCartRepository()
    
    func saveCart(cart: CartData) throws {
        do {
            let cartData = try JSONEncoder().encode(cart)
            UserDefaults.standard.set(cartData, forKey: RecordName.CartData.rawValue)
        } catch {
            throw ActionFailure.FailedAction
        }
    }
    
    func fecthCart() -> CartData? {
        guard
            let cartData = UserDefaults.standard.data(forKey: RecordName.CartData.rawValue)
        else {
            return nil
        }
        let data = try? JSONDecoder().decode(CartData.self, from: cartData)
        return data
    }
    
    func removeCart(cart: CartData) throws {
        let emptyCart = CartData(
            clothOwner: ClothOwner(
                userID: "",
                username: "",
                contact: "",
                latitude: -1.0,
                longitude: -1.0,
                sugestedAmount: -1
            ),
            clothItems: [String]()
        )
        do { try saveCart(cart: emptyCart) } catch {
            throw ActionFailure.FailedAction
        }
    }
}
