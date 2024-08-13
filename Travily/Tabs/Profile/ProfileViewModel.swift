import UIKit

final class ProfileViewModel: NSObject, ProfileHeaderViewDelegate {
    private let coordinator: ProfileCoordinator
    private let storage: TripStorage
    private let userService: UserService
    private let userLogin: String
    lazy var isCurrentUser: Bool = {
        userService.isCurrentUser(login: userLogin)
    }()
    var onTripsNumberDidChange: ((Int) -> Void)?
    var onUserTripsDidChange: (([Trip]) -> Void)?
    private(set) var userTrips: [Trip] = [] {
        didSet {
            onUserTripsDidChange?(userTrips)
            onTripsNumberDidChange?(userTrips.count)
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
    
    func createNew(trip: TripData) {
        storage.addNew(tripData: trip) { result in
            if result {
                self.updateUserTrips()
                //TODO: новая поездка появляется но в хэдере значение не обновляется
            }
        }
    }
    
    func onMessageButtonTap() {
        alertMessage = "Введите текст сообщения:"
    }
    
    func onCreateTripButtonTap() {
        coordinator.showCreateTripForm(viewModel: self)
    }
    
    func showImagePicker(delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate) {
        coordinator.presentImagePicker(delegate: delegate)
    }
}


//
//extension ProfileViewModel: ProfileHeaderViewDelegate {
//    var onTripsNumberDidChange: ((Int) -> Void)?
//    
//    
//    func onMessageButtonTap() {
//        alertMessage = "Введите текст сообщения:"
//    }
//    
//    func onCreateTripButtonTap() {
//        coordinator.showCreateTripForm(viewModel: self)
//    }
//}
