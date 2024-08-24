import UIKit

struct Trip {
    let id: String
    let userLogin: String
    let destination: String
    let period: String
    let about: String?
    ///значение опционально, чтобы в тестовых экземплярах не ставить заглушку ?? UIImage()
    let images: [UIImage?]
    
    var keyedValues: [String: Any?] {
        [
            "id": id,
            "userLogin": userLogin,
            "destination": destination,
            "period": period,
            "about": about,
            "images": images.compactMap { $0?.heicData() }
        ]
    }
}

struct TripData {
    let destination: String
    let period: String
    let about: String?
    let images: [UIImage?]
}
