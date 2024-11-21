// 
//  ProfileViewModel.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation
import Combine
import CoreLocation

class ProfileViewModel: ObservableObject {
    private let profileUseCase = DefaultProfileUseCase()
    private let urlManager = URLSharingManager()
    private let locationManager = LocationManager()
    private var originalUser: LocalUserEntity = LocalUserEntity(username: "", contactInfo: "", coordinate: (0.0, 0.0), sugestedMinimal: 0)
    
    @Published var selfUser: LocalUserEntity = LocalUserEntity(username: "", contactInfo: "", coordinate: (0.0, 0.0), sugestedMinimal: 0)
    @Published var firstLetter: String = "?"
    @Published var disableButton = true
    
    private var cancellables = [AnyCancellable]()
    private let viewDidLoad = PassthroughSubject<Void, Never>()
    
    init() {
        do {
            self.originalUser = try profileUseCase.fetchSelfUser()
            self.selfUser = try profileUseCase.fetchSelfUser()
        } catch {
            print("error: \(error.localizedDescription)")
//            self.originalUser = LocalUserEntity(username: "", contactInfo: "", coordinate: (0.0, 0.0), sugestedMinimal: 0)
//            self.selfUser = LocalUserEntity(username: "", contactInfo: "", coordinate: (0.0, 0.0), sugestedMinimal: 0)
        }
        
        setFirstLetter()
    }
    
    init(id: String?) {
        print("hello init lain")
        fetchOthers(id: id)
        viewDidLoad.send()
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }

    func fetchOthers(id: String?) {
        guard let userID = id else { return }
        viewDidLoad
            .receive(on: DispatchQueue.global())
            .flatMap {
                return self.profileUseCase.fetchUser(id: userID)
                    .map { Result.success($0 ?? UserEntity()) }
                    .catch { Just(Result.failure($0)) }
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] resultingUser in
                guard let self else { return }
                
                switch resultingUser {
                case .success(let user):
                    self.selfUser = user.mapToLocalUser()
                    self.originalUser = user.mapToLocalUser()
                    setFirstLetter()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .store(in: &cancellables)
    }
    
    func updateUser() throws {
        Task {
            do {
                try await profileUseCase.updateProfile(profile: self.selfUser)
            } catch {
                throw ActionFailure.FailedAction
            }
            
            setFirstLetter()
        }
    }
    
    func setFirstLetter() {
        self.firstLetter = selfUser.username.first?.uppercased() ?? "?"
    }
    
    func getFirstLetter(item: CatalogDisplayEntity) -> String {
        return item.owner.username.first?.uppercased() ?? "?"
    }
    
    func getUsername(item: CatalogDisplayEntity) -> String {
        return item.owner.username
    }
    
    func getDistance(item: CatalogDisplayEntity) -> Double {
        return item.distance ?? -1
    }
    
    func checkDisableButton() {
        let checkName = selfUser.username == originalUser.username || selfUser.username.isEmpty
        let checkContact = selfUser.contactInfo == originalUser.contactInfo || selfUser.contactInfo.isEmpty
        let checkAddress = selfUser.address == originalUser.address || selfUser.address.isEmpty
        let checkCoordinate = selfUser.coordinate == originalUser.coordinate
        let checkSuggestedMinimal = selfUser.sugestedMinimal == originalUser.sugestedMinimal
        
        self.disableButton = checkName && checkContact && checkAddress && checkCoordinate && checkSuggestedMinimal
    }
    
    func checkSelfUser(id: String) -> Bool {
        var user = LocalUserEntity(username: "", contactInfo: "", coordinate: (0.0, 0.0), sugestedMinimal: 0)
        
        do {
            user = try profileUseCase.fetchSelfUser()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        
        if user.userID == id {
            return true
        } else {
            return false
        }
    }
    
    func getUserDistance() -> String {
        let distance = locationManager.calculateDistance(userLocation: CLLocation(latitude: LocalUserDefaultRepository.shared.fetch()?.latitude ?? 0, longitude: LocalUserDefaultRepository.shared.fetch()?.longitude ?? 0), otherUserLocation: CLLocation(latitude: selfUser.coordinate.lat, longitude: selfUser.coordinate.lon))
        
        return "\(ceil(distance)) km"
    }
    
    func generateShareUserLink(userId: String?) -> URL {
        return urlManager.generateShareProfileLink(userID: userId)
    }
}

