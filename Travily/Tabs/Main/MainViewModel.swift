import Foundation

final class MainViewModel {
    private let coordinator: MainCoordinator
    private let storage: TripStorage
    private let userService: UserService
    
    var onUsersTripsDidChange: (([Trip]) -> Void)?
    private(set) var allUsersTrips: [Trip] = [] {
        didSet {
            onUsersTripsDidChange?(allUsersTrips)
        }
    }
    
    init(coordinator: MainCoordinator, storage: TripStorage, userService: UserService) {
        self.coordinator = coordinator
        self.storage = storage
        self.userService = userService
    }
    
    ///получаем поездки всех, на кого подписан текущий авторизованный юзер + его поездки
    func updateAllUsersTrips() {
        storage.getAllTrips(by: ["Rachel78", "doctor-ross", "thebestgirl"]) { trips in
            self.allUsersTrips = trips
        }
    }
    
    func isFavorite(tripId: String) -> Bool {
        var isFavorite = false
        storage.isFavorite(tripId: tripId) { result in
            isFavorite = result
        }
        return isFavorite
    }
    
    func getUserData(login: String) -> UserProfileData? {
        var userProfileData: UserProfileData? = nil
        userService.getUser(with: login) { user in
            userProfileData = user.getProfileData()
        }
        return userProfileData
    }
    
    func goToAuthorPage(tripIndex: Int) {
        let trip = allUsersTrips[tripIndex]
        coordinator.openPage(userLogin: trip.userLogin)
    }
    
    func changeFavoriteStatus(tripIndex: Int) {
        let trip = allUsersTrips[tripIndex]
        
        //TODO: не работает удаление поста, isFavorite не меняется, всегда false
        if isFavorite(tripId: trip.id) {
            storage.removeFromFavorite(tripId: trip.id) { result in
                if result {
                    print("=== trip deleted")
                    self.updateAllUsersTrips()
                } else {
                    print("error: trip did not delete")
                }
            }
        } else {
            storage.saveFavorite(trip: trip) { result in
                if result {
                    print("=== trip saved")
                    self.updateAllUsersTrips()
                } else {
                    print("error: trip did not saved")
                }
            }
        }
    }
}
