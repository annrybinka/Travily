import Foundation
import RealmSwift

final class UserRealm: Object {
    @objc dynamic var login: String?
    @objc dynamic var fullName: String?
    @objc dynamic var avatar: Data?
    @objc dynamic var aboutMe: String?
    @objc dynamic var followers: Int = 0
    var subscriptions = List<String>()
    var trips = List<String>()
    var favoriteTrips = List<String>()
    var likedTrips = List<String>()
    
    override class func primaryKey() -> String? {
        "login"
    }
}
