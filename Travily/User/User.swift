import UIKit

final class User {
    let login: String
    let fullName: String
    let avatar: UIImage
    let aboutMe: String
    let followers: Int
    let subscriptions: Int
    var trips: [Trip]
    var favoriteTrips: [Trip]
    
    init(
        login: String,
        fullName: String,
        avatar: UIImage,
        aboutMe: String,
        followers: Int,
        subscriptions: Int,
        trips: [Trip],
        favoriteTrips: [Trip]
    ) {
        self.login = login
        self.fullName = fullName
        self.avatar = avatar
        self.aboutMe = aboutMe
        self.followers = followers
        self.subscriptions = subscriptions
        self.trips = trips
        self.favoriteTrips = favoriteTrips
    }
    
    func getProfileData() -> UserProfileData {
        UserProfileData(
            login: login,
            fullName: fullName,
            avatar: avatar,
            aboutMe: aboutMe,
            followersNumber: followers,
            subscriptionsNumber: subscriptions,
            tripsNumber: trips.count,
            favoriteTripsNumber: favoriteTrips.count
        )
    }
}

let testUser = User(
    login: "testUser",
    fullName: "Test User",
    avatar: UIImage(systemName: "person.crop.circle") ?? UIImage(),
    aboutMe: "",
    followers: 1,
    subscriptions: 1,
    trips: testTrips,
    favoriteTrips: []
)

let userRachel = User(
    login: "Rachel78",
    fullName: "Рейчел Грин",
    avatar: UIImage(named: "rg") ?? UIImage(),
    aboutMe: "Всем привет! Я очень люблю моду и постоянно посещаю самые стильные горда нашей планеты. Следите за моими путешествиями и вдохновляйтесь ❤️",
    followers: 100,
    subscriptions: 145,
    trips: rachelTrips,
    favoriteTrips: []
)

let userFibs = User(
    login: "thebestgirl",
    fullName: "Фиби Буффе",
    avatar: UIImage(named: "fb") ?? UIImage(),
    aboutMe: "Красота, которую вы видите в окружающем мире, есть отражение красоты внутри вас",
    followers: 5,
    subscriptions: 5,
    trips: fibsTrips,
    favoriteTrips: []
)

let userRoss = User(
    login: "doctor-ross",
    fullName: "Рос Геллер",
    avatar: UIImage(named: "ross") ?? UIImage(),
    aboutMe: "Учёный палеонтолог, часто бываю на раскопках.",
    followers: 11096,
    subscriptions: 12578,
    trips: rossTrips,
    favoriteTrips: []
)
