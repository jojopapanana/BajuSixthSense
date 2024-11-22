//
//  ClothCartViewModel.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 15/11/24.
//

import Foundation
import Combine
import CoreLocation

class ClothCartViewModel: ObservableObject {
    static let shared = ClothCartViewModel()
    
    @Published var catalogCart = CartData()
    private let cartUseCase = CartUseCase()
    private var cancelables = [AnyCancellable]()
    private var locationManager = LocationManager()
    
    private var viewDidLoad = PassthroughSubject<Void, Never>()
    @Published var clothEntities: DataState<[ClothEntity]> = .Initial
    @Published var isSheetPresented = false
    
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
        
        let ids = self.catalogCart.clothItems
        print("ids: \(ids)")
        
        viewDidLoad
            .receive(on: DispatchQueue.global(qos: .background))
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
                    print(clothes.count)
                case .failure(let error):
                    self.clothEntities = .Failure(error)
                }
            }
            .store(in: &cancelables)
    }
    
    func fetchCatalogCart() {
        self.catalogCart = cartUseCase.fetchCartItem()
    }
    
    func updateCatalogCart(owner: ClothOwner, cloth: ClothEntity) throws {
        print("owner: \(owner.username) cloth: \(cloth.id ?? "")")
        var data = self.clothEntities.value ?? []
        
        if(self.catalogCart.clothItems.contains(cloth.id ?? "")){
            removeFromCartCatalog(id: cloth.id ?? "")
            removeCartItem(cloth: cloth)
        } else {
            if self.catalogCart.clothOwner.userID.isEmpty {
                print("masuk user baru")
                self.catalogCart.clothOwner = owner
                self.catalogCart.clothItems.append(cloth.id ?? "")
                data.append(cloth)
            } else if !self.catalogCart.clothOwner.userID.isEmpty && !self.catalogCart.clothOwner.contact.isEmpty {
                if self.catalogCart.clothOwner.userID == cloth.owner {
                    self.catalogCart.clothItems.append(cloth.id ?? "")
                    data.append(cloth)
                } else {
                    print("oops user berbeda")
                    isSheetPresented = true
                }
            }
            
            self.clothEntities = .Success(data)
        }
        
        do {
            try cartUseCase.updateCartItem(item: self.catalogCart)
        } catch {
            throw ActionFailure.FailedAction
        }
    }
    
    func emptyCurrCart() throws {
        do {
            print("this is emptying cart")
            try cartUseCase.emptyCart()
            
            guard var data = self.clothEntities.value else { return }
            
            data.removeAll()
            self.clothEntities = .Success(data)
            self.catalogCart.clothItems.removeAll()
            self.catalogCart.clothOwner = ClothOwner(userID: "", username: "", contact: "", latitude: 0, longitude: 0, sugestedAmount: 0)
        } catch {
            throw ActionFailure.FailedAction
        }
    }
    
    func removeFromCartCatalog(id: String){
        print("halo masuk remove BARU")
        if self.catalogCart.clothItems.isEmpty{
            return
        }
        
        if let idx = self.catalogCart.clothItems.firstIndex(of: id){
            self.catalogCart.clothItems.remove(at: idx)
        }
    }
    
    func removeCartItem(cloth: ClothEntity) {
        
        if self.clothEntities.value == nil {
            return
        }
        
        guard
            var data = self.clothEntities.value,
            let idx = data.firstIndex(where: {$0.id == cloth.id})
        else {
            print("gagal guard")
            return }
        
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
        let distance = locationManager.calculateDistance(userLocation: CLLocation(latitude: LocalUserDefaultRepository.shared.fetch()?.latitude ?? 0, longitude: LocalUserDefaultRepository.shared.fetch()?.longitude ?? 0), otherUserLocation: CLLocation(latitude: catalogCart.clothOwner.latitude, longitude: catalogCart.clothOwner.longitude))
        
        return "\(ceil(distance)) km"
    }
    
    func getRecommended() -> String {
        return String(self.catalogCart.clothOwner.sugestedAmount)
    }
    
    func getContactInfo() -> String {
        return self.catalogCart.clothOwner.contact
    }
}
