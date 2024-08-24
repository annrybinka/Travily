import Foundation

final class MainViewModel {
    private let coordinator: MainCoordinator
    private let userService: TripUserService
    
    var onUsersTripsDidChange: (([Trip]) -> Void)?
    private(set) var feedTrips: [Trip] = [] {
        didSet {
            onUsersTripsDidChange?(feedTrips)
        }
    }
    
    init(coordinator: MainCoordinator, userService: TripUserService) {
        self.coordinator = coordinator
        self.userService = userService
    }
    
    ///получаем поездки всех, на кого подписан текущий авторизованный юзер + его поездки
    func updateFeedTrips() {
        userService.getCurrentUser { [weak self] user in
            let usersForFeed = user.subscriptions + [user.login]
            self?.userService.getAllTrips(by: usersForFeed) { trips in
                self?.feedTrips = trips
            }
        }
    }
    
    ///получаем данные для конфигурации ячеек с поездками
    func isMine(tripIndex: Int) -> Bool {
        let trip = feedTrips[tripIndex]
        return userService.isCurrentUser(login: trip.userLogin)
    }
    
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
            result = user.likedTrips.contains { $0 == tripId }
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
    
    func deleteTrip(tripIndex: Int) {
        let trip = feedTrips[tripIndex]
        userService.delete(tripId: trip.id) { result in
            if result {
                self.updateFeedTrips()
            } else {
                print("error: trip did not delete")
            }
        }
    }

    func changeLikeStatus(tripIndex: Int) {
        let trip = feedTrips[tripIndex]
        userService.changeLikeStatus(tripId: trip.id) { [weak self] result in
            if result {
                self?.updateFeedTrips()
            } else {
                print("error: LikeStatus did not change")
            }
        }
    }
    
    func changeFavoriteStatus(tripIndex: Int) {
        let trip = feedTrips[tripIndex]
        userService.changeFavoriteStatus(tripId: trip.id) { [weak self] result in
            if result {
                self?.updateFeedTrips()
            } else {
                print("error: FavoriteStatus did not change")
            }
        }
    }
}
