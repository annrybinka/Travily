import Foundation

final class UserTripsStorage {
    func getTrips(userLogin: String) -> [Trip] {
        guard let trips = userTrips[userLogin] else {
            return []
        }
        return trips
    }
}

var userTrips: [String: [Trip]] = [
    "Rachel78": rachelTrips,
    "thebestgirl": fibsTrips,
    "doctor-ross": rossTrips
]
