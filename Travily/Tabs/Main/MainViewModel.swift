import Foundation

final class MainViewModel {
    private let coordinator: MainCoordinator
    private let storage: TripStorage
    private let userService: UserService
    
    var onUsersTripsDidChange: (([Trip]) -> Void)?
    private(set) var feedTrips: [Trip] = [] {
        didSet {
            onUsersTripsDidChange?(feedTrips)
        }
    }
    
    init(coordinator: MainCoordinator, storage: TripStorage, userService: UserService) {
        self.coordinator = coordinator
        self.storage = storage
        self.userService = userService
    }
    
    ///получаем поездки всех, на кого подписан текущий авторизованный юзер + его поездки
    func updateFeedTrips() {
        storage.getAllTrips(
            by: ["Rachel78", "doctor-ross", "thebestgirl"]
        ) { [weak self] trips in
            self?.feedTrips = trips
        }
    }
    
    ///получаем данные для конфигурации ячеек с поездками
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
    
    func getUserData(login: String) -> UserProfileData? {
        var userProfileData: UserProfileData? = nil
        userService.getUser(with: login) { user in
            userProfileData = user.getProfileData()
        }
        return userProfileData
    }
    
    ///обработка нажатий на разные элементы ячейки с поездкой
    func goToAuthorPage(tripIndex: Int) {
        let trip = feedTrips[tripIndex]
        coordinator.openPage(userLogin: trip.userLogin)
    }
    
    func changeLikeStatus(tripIndex: Int) {
        let trip = feedTrips[tripIndex]
        userService.getCurrentUser { user in
            if isLiked(tripId: trip.id) {
                user.likedTrips.removeAll { $0 == trip.id }
            } else {
                user.likedTrips.append(trip.id)
            }
        }
        self.updateFeedTrips()
    }
    
    func changeFavoriteStatus(tripIndex: Int) {
        let trip = feedTrips[tripIndex]
        if isFavorite(tripId: trip.id) {
            storage.removeFromFavorite(tripId: trip.id) { result in
                if result {
                    self.updateFeedTrips()
                } else {
                    print("error: trip did not delete")
                }
            }
        } else {
            storage.saveFavorite(trip: trip) { result in
                if result {
                    self.updateFeedTrips()
                } else {
                    print("error: trip did not saved")
                }
            }
        }
    }
}
