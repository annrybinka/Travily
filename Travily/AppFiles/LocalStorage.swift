import UIKit

final class LocalStorage {
    private let rachelTrips = [
        Trip(
            id: "trip2024-07-01 00:59:22 +0000Rachel78",
            userLogin: "Rachel78",
            destination: "Париж, Франция",
            period: "июнь, 2024 год",
            about: "Классно, когда по работе нужно слетать в самый романтичный город этого мира. Я скучала!\n\nВ этот раз мы готовили модный показ совместно с домом моды Dior, а их офис как раз находится недалеко от Эйфелевой башни. На обеденном перерыве я всегда выхожу прогуляться в этом красивом месте. А ещё знаю, где тут можно найти самые вкусные круассаны 😊",
            images: [UIImage(named: "paris2"), UIImage(named: "paris3")]
        ),
        Trip(
            id: "trip2023-03-12 00:59:22 +0000Rachel78",
            userLogin: "Rachel78",
            destination: "Париж, Франция",
            period: "март, 2023 год",
            about: nil,
            images: [UIImage(named: "paris2")]
        ),
        Trip(
            id: "trip2020-10-22 09:43:41 +0000Rachel78",
            userLogin: "Rachel78",
            destination: "Париж, Франция",
            period: "2020 год",
            about: "Меня отправили в командировку в Париж!",
            images: [UIImage(named: "paris1")]
        )
    ]

    private let fibsTrips = [
        Trip(
            id: "trip2022-01-02 21:12:09 +0000thebestgirl",
            userLogin: "thebestgirl",
            destination: "Нью Йорк, США",
            period: "2022 год",
            about: "Играю возле Центральной кофейни каждый вторник и четверг. Приходите, буду рада сыграть для вас свои лучшие песни.",
            images: [UIImage(named: "fibs"), UIImage(named: "cp")]
        )
    ]

    private let rossTrips = [
        Trip(
            id: "trip2021-03-26 06:07:08 +0000doctor-ross",
            userLogin: "doctor-ross",
            destination: "Чукотский АО, Россия",
            period: "19-25 марта 2021 год",
            about: "Наши коллеги из России пригласили нас посмотреть на самого «молодого» мамонта.\n\nУченые из Северо-Восточного комплексного научно-исследовательского института (СВКНИИ) ДВО РАН проводя полевые работы на Чукотке, обнаружили кости мамонта. Возраст останков не превышает 12 тысяч лет, это просто невероятно! Мы прилетели на другой континент, чтобы лично посмотреть на уникальную находку и помочь с её оформлением.",
            images: [UIImage(named: "ross4")]
        ),
        Trip(
            id: "trip2017-08-12 00:59:22 +0000doctor-ross",
            userLogin: "doctor-ross",
            destination: "Сан-Диего, Калифорния, США",
            period: "2017 год",
            about: "Мы нашли новые следы древнего человека в Америке!\n\nВо время раскопок в Сан-Диего наша археологическая группа (на фото) нашла кости мастодонта со следами повреждений, которые, по-видимому, нанесли древние люди. Датировка костей показала, что мастодонт жил около 130 тысяч лет назад, то есть почти на 100 тысяч лет раньше наиболее общепринятого времени заселения Америки и гораздо раньше выхода людей современного типа из Африки.",
            images: [UIImage(named: "ross3"), UIImage(named: "ross1"), UIImage(named: "ross2")]
        )
    ]

    private let testTrips = [
        Trip(
            id: "trip2024-08-11 12:21:22 +0000testUser",
            userLogin: "testUser",
            destination: "Караганда",
            period: "1984 год",
            about: nil,
            images: []
        )
    ]
    
    func getLocalTrips() -> [Trip] {
        rachelTrips + fibsTrips + rossTrips + testTrips
    }
    
    func getLocalUsers() -> [User] {
        [
            User(
                login: "Rachel78",
                fullName: "Рейчел Грин",
                avatar: UIImage(named: "rg") ?? UIImage(),
                aboutMe: "Всем привет! Я очень люблю моду и постоянно посещаю самые стильные горда нашей планеты. Следите за моими путешествиями и вдохновляйтесь ❤️",
                followers: 100,
                subscriptions: ["doctor-ross", "thebestgirl", "user1", "user2", "user3", "user4", "user5"],
                trips: rachelTrips.map { $0.id },
                favoriteTrips: [],
                likedTrips: ["trip2017-08-12 00:59:22 +0000doctor-ross", "trip2022-01-02 21:12:09 +0000thebestgirl", "trip2024-07-01 00:59:22 +0000Rachel78"]
            ),
            User(
                login: "thebestgirl",
                fullName: "Фиби Буффе",
                avatar: UIImage(named: "fb") ?? UIImage(),
                aboutMe: "Красота, которую вы видите в окружающем мире, есть отражение красоты внутри вас",
                followers: 5,
                subscriptions: ["doctor-ross", "Rachel78"],
                trips: fibsTrips.map { $0.id },
                favoriteTrips: [],
                likedTrips: ["trip2017-08-12 00:59:22 +0000doctor-ross", "trip2024-07-01 00:59:22 +0000Rachel78"]
            ),
            User(
                login: "doctor-ross",
                fullName: "Рос Геллер",
                avatar: UIImage(named: "ross") ?? UIImage(),
                aboutMe: "Учёный палеонтолог, часто бываю на раскопках.",
                followers: 11096,
                subscriptions: ["Rachel78", "thebestgirl", "testUser"],
                trips: rossTrips.map { $0.id },
                favoriteTrips: [],
                likedTrips: ["trip2020-10-22 09:43:41 +0000Rachel78", "trip2023-03-12 00:59:22 +0000Rachel78", "trip2024-07-01 00:59:22 +0000Rachel78"]
            ),
            User(
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
        ]
    }
}
