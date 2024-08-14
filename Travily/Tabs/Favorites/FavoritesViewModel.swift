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
    
    func isLiked(tripId: String) -> Bool {
        var result = false
        userService.getCurrentUser { user in
            result = user.likedTrips.contains(where: { $0 == tripId })
        }
        return result
    }
    
    func getLikesNumber(tripId: String) -> Int {
        var result = 0
        userService.getUsersLiked(tripId: tripId) { users in
            result = users.count
        }
        return result
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
    
    func changeLikeStatus(tripIndex: Int) {
        let trip = savedTrips[tripIndex]
        userService.getCurrentUser { user in
            if isLiked(tripId: trip.id) {
                user.likedTrips.removeAll { $0 == trip.id }
            } else {
                user.likedTrips.append(trip.id)
            }
        }
        self.updateSavedTrips()
    }
    
    func removeFromFavorites(tripIndex: Int) {
        let trip = savedTrips[tripIndex]
        storage.removeFromFavorite(tripId: trip.id) { result in
            if result {
                self.updateSavedTrips()
            } else {
                print("error: trip did not delete")
            }
        }
    }
}
