import Foundation
    
final class FavoritesViewModel {
    private let coordinator: FavoritesCoordinator
    private let userService: TripUserService

    var onSavedTripsDidChange: (([Trip]) -> Void)?
    private(set) var savedTrips: [Trip] = [] {
        didSet {
            onSavedTripsDidChange?(savedTrips)
        }
    }
    
    init(coordinator: FavoritesCoordinator, userService: TripUserService) {
        self.coordinator = coordinator
        self.userService = userService
    }

    func updateSavedTrips() {
        userService.getAllFavoriteTrips() { trips in
            self.savedTrips = trips
        }
    }
    
    ///получаем данные для конфигурации ячеек с поездками    
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
        let trip = savedTrips[tripIndex]
        coordinator.openPage(userLogin: trip.userLogin)
    }
    
    func changeLikeStatus(tripIndex: Int) {
        let trip = savedTrips[tripIndex]
        userService.changeLikeStatus(tripId: trip.id) { [weak self] result in
            if result {
                self?.updateSavedTrips()
            } else {
                print("error: LikeStatus did not change")
            }
        }
    }
    
    func removeFromFavorites(tripIndex: Int) {
        let trip = savedTrips[tripIndex]
        userService.changeFavoriteStatus(tripId: trip.id) { [weak self] result in
            if result {
                self?.updateSavedTrips()
            } else {
                print("error: FavoriteStatus did not change")
            }
        }
    }
}
