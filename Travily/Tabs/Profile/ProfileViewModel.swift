import UIKit

final class ProfileViewModel {
    private let coordinator: ProfileCoordinator
    private let userService: TripUserService
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
    
    init(coordinator: ProfileCoordinator, userService: TripUserService, userLogin: String) {
        self.coordinator = coordinator
        self.userService = userService
        self.userLogin = userLogin
    }
    
    func updateUserTrips() {
        userService.getAllTrips(by: [userLogin]) { trips in
            self.userTrips = trips
        }
    }
    
    ///получаем данные для конфигурации ячеек с поездками
    func isFavorite(tripId: String) -> Bool {
        var result = false
        userService.getCurrentUser { user in
            result = user.favoriteTrips.contains(where: { $0 == tripId })
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
    
    ///получаем данные профиля через метод getUser, а не getCurrentUser, так как вьюмодель позволяет открыть страницу как текущего юзера, так и других пользователей
    func getUserData() -> UserProfileData? {
        var userProfileData: UserProfileData? = nil
        userService.getUser(with: userLogin) { user in
            userProfileData = user.getProfileData()
        }
        return userProfileData
    }
    
    ///обработка нажатий на разные элементы ячейки с поездкой
    func deleteTrip(tripIndex: Int) {
        let trip = userTrips[tripIndex]
        userService.delete(tripId: trip.id) { result in
            if result {
                self.updateUserTrips()
            } else {
                print("error: trip did not delete")
            }
        }
    }
    
    func changeLikeStatus(tripIndex: Int) {
        let trip = userTrips[tripIndex]
        userService.changeLikeStatus(tripId: trip.id) { [weak self] result in
            if result {
                self?.updateUserTrips()
            } else {
                print("error: LikeStatus did not change")
            }
        }
    }
    
    func changeFavoriteStatus(tripIndex: Int) {
        let trip = userTrips[tripIndex]
        userService.changeFavoriteStatus(tripId: trip.id) { [weak self] result in
            if result {
                self?.updateUserTrips()
            } else {
                print("error: FavoriteStatus did not change")
            }
        }
    }
    
    ///обработка действий в хэдере профиля
    func createNew(trip: TripData) {
        userService.addNewTrip(with: trip) { result in
            if result {
                self.updateUserTrips()
            }
        }
    }
    
    func showImagePicker(
        delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate
    ) {
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
