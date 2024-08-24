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
            "avatar": avatar.pngData(),
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

let userRachel = User(
    login: "Rachel78",
    fullName: "Рейчел Грин",
    avatar: UIImage(named: "rg") ?? UIImage(),
    aboutMe: "Всем привет! Я очень люблю моду и постоянно посещаю самые стильные горда нашей планеты. Следите за моими путешествиями и вдохновляйтесь ❤️",
    followers: 100,
    subscriptions: ["doctor-ross", "thebestgirl", "user1", "user2", "user3", "user4", "user5"],
    trips: rachelTrips.map { $0.id },
    favoriteTrips: [],
    likedTrips: ["trip2017-08-12 00:59:22 +0000doctor-ross", "trip2022-01-02 21:12:09 +0000thebestgirl", "trip2024-07-01 00:59:22 +0000Rachel78"]
)

let userFibs = User(
    login: "thebestgirl",
    fullName: "Фиби Буффе",
    avatar: UIImage(named: "fb") ?? UIImage(),
    aboutMe: "Красота, которую вы видите в окружающем мире, есть отражение красоты внутри вас",
    followers: 5,
    subscriptions: ["doctor-ross", "Rachel78"],
    trips: fibsTrips.map { $0.id },
    favoriteTrips: [],
    likedTrips: ["trip2017-08-12 00:59:22 +0000doctor-ross", "trip2024-07-01 00:59:22 +0000Rachel78"]
)

let userRoss = User(
    login: "doctor-ross",
    fullName: "Рос Геллер",
    avatar: UIImage(named: "ross") ?? UIImage(),
    aboutMe: "Учёный палеонтолог, часто бываю на раскопках.",
    followers: 11096,
    subscriptions: ["Rachel78", "thebestgirl", "testUser"],
    trips: rossTrips.map { $0.id },
    favoriteTrips: [],
    likedTrips: ["trip2020-10-22 09:43:41 +0000Rachel78", "trip2023-03-12 00:59:22 +0000Rachel78", "trip2024-07-01 00:59:22 +0000Rachel78"]
)

let testUser = User(
    login: "testUser",
    fullName: "Test User",
    avatar: UIImage(systemName: "person.crop.circle") ?? UIImage(),
    aboutMe: "",
    followers: 1,
    subscriptions: ["thebestgirl", "doctor-ross", "Rachel78"],
    trips: testTrips.map { $0.id },
    favoriteTrips: [],
    likedTrips: ["trip2017-08-12 00:59:22 +0000doctor-ross", "trip2020-10-22 09:43:41 +0000Rachel78", "trip2022-01-02 21:12:09 +0000thebestgirl", "trip2024-07-01 00:59:22 +0000Rachel78"]
)
