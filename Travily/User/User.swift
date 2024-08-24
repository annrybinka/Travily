import UIKit

final class User {
    let login: String
    let fullName: String
    let avatar: UIImage
    let aboutMe: String
    let followers: Int
    let subscriptions: [String]
    var trips: [String]
    var favoriteTrips: [String]
    var likedTrips: [String]
    
    var keyedValues: [String: Any?] {
        [
            "login": login,
            "fullName": fullName,
            "avatar": avatar.heicData(),
            "aboutMe": aboutMe,
            "followers": followers,
            "subscriptions": subscriptions,
            "trips": trips,
            "favoriteTrips": favoriteTrips,
            "likedTrips": likedTrips
        ]
    }
    
    init(
        login: String,
        fullName: String,
        avatar: UIImage,
        aboutMe: String,
        followers: Int,
        subscriptions: [String],
        trips: [String],
        favoriteTrips: [String],
        likedTrips: [String]
    ) {
        self.login = login
        self.fullName = fullName
        self.avatar = avatar
        self.aboutMe = aboutMe
        self.followers = followers
        self.subscriptions = subscriptions
        self.trips = trips
        self.favoriteTrips = favoriteTrips
        self.likedTrips = likedTrips
    }
    
    func getProfileData() -> UserProfileData {
        UserProfileData(
            login: login,
            fullName: fullName,
            avatar: avatar,
            aboutMe: aboutMe,
            followersNumber: followers,
            subscriptionsNumber: subscriptions.count,
            tripsNumber: trips.count
        )
    }
}
