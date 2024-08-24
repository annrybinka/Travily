import Foundation
import RealmSwift

final class TripRealm: Object {
    @objc dynamic var id: String?
    @objc dynamic var userLogin: String?
    @objc dynamic var destination: String?
    @objc dynamic var period: String?
    @objc dynamic var about: String?
    let images = List<Data>()
    
    override class func primaryKey() -> String? {
        "id"
    }
}
