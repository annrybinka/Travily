import UIKit

final class ProfileViewModel {
    private let coordinator: ProfileCoordinator
    private let storage: TripStorage
    private let userService: UserService
    private let userLogin: String
    lazy var isCurrentUser: Bool = {
        userService.isCurrentUser(login: userLogin)
    }()
    var onUserTripsDidChange: (([Trip]) -> Void)?
    private(set) var userTrips: [Trip] = [] {
        didSet {
            onUserTripsDidChange?(userTrips)
        }
    }
    var onAlertMessageDidChange: ((String) -> Void)?
    private(set) var alertMessage: String = "" {
        didSet {
            onAlertMessageDidChange?(alertMessage)
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
    
    func isFavorite(tripId: String) -> Bool {
        var result = false
        userService.getCurrentUser { user in
            result = user.favoriteTrips.contains(where: { $0.id == tripId })
        }
        return result
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
    
    func getUserData() -> UserProfileData? {
        var userProfileData: UserProfileData? = nil
        userService.getUser(with: userLogin) { user in
            userProfileData = user.getProfileData()
        }
        return userProfileData
    }
    
    func changeLikeStatus(tripIndex: Int) {
        let trip = userTrips[tripIndex]
        userService.getCurrentUser { user in
            if isLiked(tripId: trip.id) {
                user.likedTrips.removeAll { $0 == trip.id }
            } else {
                user.likedTrips.append(trip.id)
            }
        }
        self.updateUserTrips()
    }
    
    func changeFavoriteStatus(tripIndex: Int) {
        let trip = userTrips[tripIndex]
        if isFavorite(tripId: trip.id) {
            storage.removeFromFavorite(tripId: trip.id) { result in
                if result {
                    self.updateUserTrips()
                } else {
                    print("error: trip did not delete")
                }
            }
        } else {
            storage.saveFavorite(trip: trip) { result in
                if result {
                    self.updateUserTrips()
                } else {
                    print("error: trip did not saved")
                }
            }
        }
    }
    
    func createNew(trip: TripData) {
        storage.addNew(tripData: trip) { result in
            if result {
                self.updateUserTrips()
            }
        }
    }
    
    func showImagePicker(delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate) {
        coordinator.presentImagePicker(delegate: delegate)
    }
}

extension ProfileViewModel: ProfileHeaderViewDelegate {
    func onMessageButtonTap() {
        alertMessage = "Введите текст сообщения:"
    }
    
    func onCreateTripButtonTap() {
        coordinator.showCreateTripForm(viewModel: self)
    }
}
