import UIKit
import RealmSwift

final class TripUserService {
    let currentUserLogin = "Rachel78"
    
    ///методы для получения текущего или любого пользователя по его логину
    func getCurrentUser(handler: @escaping (User) -> Void) {
        do {
            let realm = try Realm()
            guard let userRealm = realm.objects(UserRealm.self).first(
                where: { $0.login == currentUserLogin }
            ) else { return }
            handler(
                User(
                    login: userRealm.login ?? "",
                    fullName: userRealm.fullName ?? "",
                    avatar: UIImage(data: userRealm.avatar!) ?? UIImage(),
                    aboutMe: userRealm.aboutMe ?? "",
                    followers: userRealm.followers,
                    subscriptions: userRealm.subscriptions.map { String($0) },
                    trips: userRealm.trips.map { String($0) },
                    favoriteTrips: userRealm.favoriteTrips.map { String($0) },
                    likedTrips: userRealm.likedTrips.map { String($0) }
                )
            )
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getUser(with login: String, handler: @escaping (User) -> Void) {
        do {
            let realm = try Realm()
            guard let userRealm = realm.objects(UserRealm.self).first(
                where: { $0.login == login }
            ) else { return }
            handler(
                User(
                    login: userRealm.login ?? "",
                    fullName: userRealm.fullName ?? "",
                    avatar: UIImage(data: userRealm.avatar!) ?? UIImage(),
                    aboutMe: userRealm.aboutMe ?? "",
                    followers: userRealm.followers,
                    subscriptions: userRealm.subscriptions.map { String($0) },
                    trips: userRealm.trips.map { String($0) },
                    favoriteTrips: userRealm.favoriteTrips.map { String($0) },
                    likedTrips: userRealm.likedTrips.map { String($0) }
                )
            )
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func isCurrentUser(login: String) -> Bool {
        login == currentUserLogin
    }
    
    ///получить все личные поездки одного или нескольких юзеров, например всех, на кого юзер подписан
    func getAllTrips(by logins: [String], handler: @escaping ([Trip]) -> Void) {
        do {
            let realm = try Realm()
            var tripsId: [String] = []
            
            logins.forEach { login in
                guard let user = realm.objects(UserRealm.self).first(
                    where: { $0.login == login }
                ) else {
                    handler([])
                    return
                }
                tripsId += user.trips
            }
            
            var allTrips: [Trip] = []
            tripsId.forEach { tripId in
                guard let tripRealm = realm.objects(TripRealm.self).first(
                    where: { $0.id == tripId }
                ) else {
                    handler([])
                    return
                }
                allTrips.append(
                    Trip(
                        id: tripRealm.id ?? "",
                        userLogin: tripRealm.userLogin ?? "",
                        destination: tripRealm.destination ?? "",
                        period: tripRealm.period ?? "",
                        about: tripRealm.about ?? "",
                        images: tripRealm.images.map { UIImage(data: $0) }
                    )
                )
            }
            handler(allTrips.sorted { $0.id > $1.id })
        } catch {
            print(error.localizedDescription)
            handler([])
        }
    }
    
    ///методы для работы с личными поездками текущего авторизованного юзера (создать, удалить)
    func addNewTrip(with tripData: TripData, handler: @escaping (Bool) -> Void) {
        do {
            let realm = try Realm()
            guard let user = realm.objects(UserRealm.self).first(
                where: { $0.login == currentUserLogin }
            ) else {
                handler(false)
                return
            }
            let id = "trip\(Date.now)\(user.login ?? currentUserLogin)"
            let trip = Trip(
                id: id,
                userLogin: user.login ?? currentUserLogin,
                destination: tripData.destination,
                period: tripData.period,
                about: tripData.about,
                images: tripData.images
            )
            
            try realm.write {
                user.trips.insert(id, at: 0)
                realm.create(
                    TripRealm.self,
                    value: trip.keyedValues
                )
                handler(true)
            }
        } catch {
            print(error.localizedDescription)
            handler(false)
        }
    }
    
    func delete(tripId: String, handler: @escaping (Bool) -> Void) {
        do {
            let realm = try Realm()
            
            guard let user = realm.objects(UserRealm.self).first(
                where: { $0.login == currentUserLogin }
            ) else {
                handler(false)
                return
            }
            guard let index = user.trips.firstIndex(
                where: { $0 == tripId }
            ) else {
                handler(false)
                return
            }
            try realm.write {
                user.trips.remove(at: index)
                handler(true)
            }
        } catch {
            print(error.localizedDescription)
            handler(false)
        }
    }
    
    ///методы для работы с избранными поездками текущего авторизованного юзера (получить все, добавить, удалить)
    func getAllFavoriteTrips(handler: @escaping ([Trip]) -> Void) {
        do {
            let realm = try Realm()
            var favoriteTrips: [Trip] = []
            getCurrentUser { user in
                user.favoriteTrips.forEach { tripId in
                    guard let tripRealm = realm.objects(TripRealm.self).first(
                        where: { $0.id == tripId }
                    ) else { return }
                    favoriteTrips.append(
                        Trip(
                            id: tripRealm.id ?? "",
                            userLogin: tripRealm.userLogin ?? "",
                            destination: tripRealm.destination ?? "",
                            period: tripRealm.period ?? "",
                            about: tripRealm.about ?? "",
                            images: tripRealm.images.map { UIImage(data: $0) }
                        )
                    )
                    handler(favoriteTrips)
                }
            }
        } catch {
            print(error.localizedDescription)
            handler([])
        }
    }
    
    func changeFavoriteStatus(tripId: String, handler: @escaping (Bool) -> Void) {
        do {
            let realm = try Realm()
            guard let user = realm.objects(UserRealm.self).first(
                where: { $0.login == currentUserLogin }
            ) else {
                handler(false)
                return
            }
            try realm.write {
                guard let index = user.favoriteTrips.firstIndex(
                    where: { $0 == tripId }
                ) else {
                    user.favoriteTrips.insert(tripId, at: 0)
                    handler(true)
                    return
                }
                user.favoriteTrips.remove(at: index)
                handler(true)
            }
        } catch {
            print(error.localizedDescription)
            handler(false)
        }
    }
    
    ///проверяем кто ставил лайк поездке среди всех юзеров
    func getUsersLiked(tripId: String, handler: @escaping ([String]) -> Void) {
        var result: [String] = []
        do {
            let realm = try Realm()
            realm.objects(UserRealm.self).forEach { user in
                if user.likedTrips.contains(where: { $0 == tripId }) {
                    result.append(user.login!)
                }
            }
            handler(result)
        } catch {
            print(error.localizedDescription)
            handler(result)
        }
    }
    
    ///поставить или снять лайк с поездки
    func changeLikeStatus(tripId: String, handler: @escaping (Bool) -> Void) {
        do {
            let realm = try Realm()
            guard let user = realm.objects(UserRealm.self).first(
                where: { $0.login == currentUserLogin }
            ) else {
                handler(false)
                return
            }
            try realm.write {
                if user.likedTrips.contains(where: { $0 == tripId }) {
                    let index = user.likedTrips.firstIndex { $0 == tripId }
                    user.likedTrips.remove(at: index!)
                } else {
                    user.likedTrips.insert(tripId, at: 0)
                }
                handler(true)
            }
        } catch {
            print(error.localizedDescription)
            handler(false)
        }
    }
}
