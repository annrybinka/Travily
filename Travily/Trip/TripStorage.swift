import Foundation

final class TripStorage {
    private let userService: UserService
    
    init(userService: UserService) {
        self.userService = userService
    }
    
    ///добавить новую запись о личной поездке текущего авторизованного юзера
    func addNew(trip: Trip, handler: @escaping (Bool) -> Void) {
        //возможно тут стоит передать данные для поездки, а саму поездку с новым id создать тут
        //id = maxId + 1, простой вариант хранить maxId тут
        //id = user.Login + user.trips.count, но тогда пропадёт порядковость всех постов
        //id = user.Login + date.now
        userService.getCurrentUser { user in
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
    
    ///проверить, добавлена ли поездка в избранные текущего авторизованного юзера
    func isFavorite(tripId: Int, handler: @escaping (Bool) -> Void) {
        userService.getCurrentUser { user in
            guard let index = user.favoriteTrips.firstIndex(where:{ $0.id == tripId}) else {
                handler(false)
                return
            }
            handler(true)
        }
    }
    
    ///добавить любую поездку в избранные текущего авторизованного юзера
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
    
    ///удалить поездку из избранного, находясь в разделе "Избранное"
    func removeFavoriteTrip(with index: Int, handler: @escaping (Bool) -> Void) {
        userService.getCurrentUser { user in
            user.favoriteTrips.remove(at: index)
        }
        handler(true)
    }
    
    ///удалить поездку из избранного, находясь в любом другом разделе, кроме "Избранное"
    func removeFromFavorite(tripId: Int, handler: @escaping (Bool) -> Void) {
        userService.getCurrentUser { user in
            guard let index = user.favoriteTrips.firstIndex(where:{ $0.id == tripId}) else { return }
            user.favoriteTrips.remove(at: index)
        }
        handler(true)
    }
}
