import Foundation
    
final class FavoritesViewModel {
    private let coordinator: FavoritesCoordinator
    private let storage: TripStorage
    private let userService: UserService

    var onSavedTripsDidChange: (([Trip]) -> Void)?
    private(set) var savedTrips: [Trip] = [] {
        didSet {
            onSavedTripsDidChange?(savedTrips)
        }
    }
    
    init(coordinator: FavoritesCoordinator, storage: TripStorage, userService: UserService) {
        self.coordinator = coordinator
        self.storage = storage
        self.userService = userService
    }

    func updateSavedTrips() {
        storage.getFavoriteTrips() { trips in
            self.savedTrips = trips
        }
    }
    
    func getUserData(login: String) -> UserProfileData? {
        var userProfileData: UserProfileData? = nil
        userService.getUser(with: login) { user in
            userProfileData = user.getProfileData()
        }
        return userProfileData
    }
    
    func goToAuthorPage(tripIndex: Int) {
        let trip = savedTrips[tripIndex]
        coordinator.openPage(userLogin: trip.userLogin)
    }
    
    func removeFromFavorites(tripIndex: Int) {
        storage.removeFavoriteTrip(with: tripIndex) { result in
            if result {
                print("=== trip deleted")
                self.updateSavedTrips()
            } else {
                print("error: trip did not delete")
            }
        }
    }
}
