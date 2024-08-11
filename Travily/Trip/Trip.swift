import UIKit

struct Trip {
    let id: Int
    let userLogin: String
    let destination: String
    let period: String
    let about: String?
    
    //MARK: значение опционально, чтобы в тестовых экземплярах не ставить заглушку ?? UIImage()
    let images: [UIImage?]
}

var rachelTrips = [
    Trip(
        id: 6,
        userLogin: "Rachel78",
        destination: "Париж, Франция",
        period: "июнь, 2024 год",
        about: "Классно, когда по работе нужно слетать в самый романтичный город этого мира. Я скучала!\n\nВ этот раз мы готовили модный показ совместно с домом моды Dior, а их офис как раз находится недалеко от Эйфелевой башни. На обеденном перерыве я всегда выхожу прогуляться в этом красивом месте. А ещё знаю, где тут можно найти самые вкусные круассаны 😊",
        images: [UIImage(named: "paris2"), UIImage(named: "paris3")]
    ),
    Trip(
        id: 5,
        userLogin: "Rachel78",
        destination: "Париж, Франция",
        period: "март, 2023 год",
        about: nil,
        images: [UIImage(named: "paris2")]
    ),
    Trip(
        id: 2,
        userLogin: "Rachel78",
        destination: "Париж, Франция",
        period: "2020 год",
        about: "Меня отправили в командировку в Париж!",
        images: [UIImage(named: "paris1")]
    )
]

var rossTrips = [
    Trip(
        id: 3,
        userLogin: "doctor-ross",
        destination: "Чукотский АО, Россия",
        period: "19-25 марта 2021 год",
        about: "Наши коллеги из России пригласили нас посмотреть на самого «молодого» мамонта.\n\nУченые из Северо-Восточного комплексного научно-исследовательского института (СВКНИИ) ДВО РАН проводя полевые работы на Чукотке, обнаружили кости мамонта. Возраст останков не превышает 12 тысяч лет, это просто невероятно! Мы прилетели на другой континент, чтобы лично посмотреть на уникальную находку и помочь с её оформлением.",
        images: [UIImage(named: "ross4")]
    ),
    Trip(
        id: 1,
        userLogin: "doctor-ross",
        destination: "Сан-Диего, Калифорния, США",
        period: "2017 год",
        about: "Мы нашли новые следы древнего человека в Америке!\n\nВо время раскопок в Сан-Диего наша археологическая группа (на фото) нашла кости мастодонта со следами повреждений, которые, по-видимому, нанесли древние люди. Датировка костей показала, что мастодонт жил около 130 тысяч лет назад, то есть почти на 100 тысяч лет раньше наиболее общепринятого времени заселения Америки и гораздо раньше выхода людей современного типа из Африки.",
        images: [UIImage(named: "ross3"), UIImage(named: "ross1"), UIImage(named: "ross2")]
    )
]

var fibsTrips = [
    Trip(
        id: 4,
        userLogin: "thebestgirl",
        destination: "Нью Йорк, США",
        period: "2022 год",
        about: "Играю возле Центральной кофейни каждый вторник и четверг. Приходите, буду рада сыграть для вас свои лучшие песни.",
        images: [UIImage(named: "fibs"), UIImage(named: "cp")]
    )
]

var testTrips = [
    Trip(
        id: UUID().hashValue,
        userLogin: "testUser",
        destination: "Караганда",
        period: "1984 год",
        about: nil,
        images: []
    )
]
