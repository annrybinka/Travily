import Foundation

final class TripStorage {
    private let userService: UserService
    
    init(userService: UserService) {
        self.userService = userService
    }
    
    ///добавить новую запись о личной поездке текущего авторизованного юзера
    func addNew(tripData: TripData, handler: @escaping (Bool) -> Void) {
        userService.getCurrentUser { user in
            let id = "trip\(Date.now)\(user.login)"
            let trip = Trip(
                id: id,
                userLogin: user.login,
                destination: tripData.destination,
                period: tripData.period,
                about: tripData.about,
                images: tripData.images
            )
            user.trips.insert(trip, at: 0)
        }
        handler(true)
    }
    
    ///получить все личные поездки как одного, так и нескольких юзеров, например всех, на кого юзер подписан
    func getAllTrips(by users: [String], handler: @escaping ([Trip]) -> Void) {
        var allTrips: [Trip] = []
        users.forEach { login in
            userService.getUser(with: login) { user in
                allTrips += user.trips
            }
        }
        handler(allTrips.sorted { $0.id > $1.id })
    }
    
    ///добавить поездку в раздел "Избранное"
    func saveFavorite(trip: Trip, handler: @escaping (Bool) -> Void) {
        userService.getCurrentUser { user in
            user.favoriteTrips.insert(trip, at: 0)
        }
        handler(true)
    }
    
    ///получить все избранные поездки текущего авторизованного юзера
    func getFavoriteTrips(handler: @escaping ([Trip]) -> Void) {
        userService.getCurrentUser { user in
            handler(user.favoriteTrips)
        }
    }
    
    ///удалить поездку из раздела "Избранное"
    func removeFromFavorite(tripId: String, handler: @escaping (Bool) -> Void) {
        userService.getCurrentUser { user in
            guard let index = user.favoriteTrips.firstIndex(where:{ $0.id == tripId}) else { return }
            user.favoriteTrips.remove(at: index)
        }
        handler(true)
    }
}
