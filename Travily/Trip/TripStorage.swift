import Foundation

var userTrips: [String: [Trip]] = [
    "Rachel78": rachelTrips,
    "thebestgirl": fibsTrips,
    "doctor-ross": rossTrips,
    "testUser": []
]

var favoriteTrips: [String: [Trip]] = [
    "Rachel78": [],
    "thebestgirl": [],
    "doctor-ross": rossTrips,
    "testUser": fibsTrips
]


final class TripStorage {
    func addNew(trip: Trip, by user: String, handler: @escaping (Bool) -> Void) {
        userTrips[user]?.append(trip)
    }
    
    func getAllTrips(by users: [String], handler: @escaping ([Trip]) -> Void) {
        var allTrips: [Trip] = []
        users.forEach { login in
            guard let trips = userTrips[login] else { return }
            allTrips += trips
        }
        handler(allTrips.sorted { $0.id > $1.id })
    }
    
    func saveFavorite(trip: Trip, for user: String, handler: @escaping (Bool) -> Void) {
        favoriteTrips[user]?.insert(trip, at: 0)
        handler(true)
    }
    
    func removeFavoriteTrip(with index: Int, for user: String, handler: @escaping (Bool) -> Void) {
        favoriteTrips[user]?.remove(at: index)
        handler(true)
    }
    
    func getFavoriteTrips(by user: String, handler: @escaping ([Trip]) -> Void) {
        guard let allTrips = favoriteTrips[user] else { return }
        handler(allTrips)
    }
}
