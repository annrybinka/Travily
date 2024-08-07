import UIKit

struct Trip {
    let id: Int
    let userLogin: String
    let destination: String
    let period: String
    let about: String?
    let images: [UIImage?]
    
    var author: User? {
        users.first { user in
            user.login == userLogin
        }
    }
}
