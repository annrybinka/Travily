import Foundation

final class ProfileViewModel {
    private let coordinator: ProfileCoordinator
    private let storage: TripStorage
    private let userService: UserService
    private let userLogin: String
    
    var onUserTripsDidChange: (([Trip]) -> Void)?
    private(set) var userTrips: [Trip] = [] {
        didSet {
            onUserTripsDidChange?(userTrips)
        }
    }
    
    init(coordinator: ProfileCoordinator, storage: TripStorage, userService: UserService, userLogin: String) {
        self.coordinator = coordinator
        self.storage = storage
        self.userService = userService
        self.userLogin = userLogin
    }
    
    func updateUserTrips() {
        storage.getAllTrips(by: [userLogin]) { trips in
            self.userTrips = trips
        }
    }
    
    func isFavorite(tripId: Int) -> Bool {
        var isFavorite = false
        storage.isFavorite(tripId: tripId) { result in
            isFavorite = result
        }
        return isFavorite
    }
    
    func getUserData() -> UserProfileData? {
        var userProfileData: UserProfileData? = nil
        userService.getUser(with: userLogin) { user in
            userProfileData = user.getProfileData()
        }
        return userProfileData
    }
    
    func addToFavorites(tripIndex: Int) {
        let trip = userTrips[tripIndex]
        if isFavorite(tripId: trip.id) {
            storage.removeFromFavorite(tripId: trip.id) { result in
                if result {
                    print("=== trip deleted")
                    self.updateUserTrips()
                } else {
                    print("error: trip did not delete")
                }
            }
        } else {
            storage.saveFavorite(trip: trip) { result in
                if result {
                    print("=== trip saved")
                    self.updateUserTrips()
                } else {
                    print("error: trip did not saved")
                }
            }
        }
    }
    
    func createNew(trip: Trip) {
        storage.addNew(trip: trip) { result in
            if result {
                self.updateUserTrips()
            }
        }
    }
}

extension ProfileViewModel: ProfileHeaderViewDelegate {    
    func onCreateTripButtonTap() {
        coordinator.showCreateTripForm(userLogin: userLogin)
    }
}
