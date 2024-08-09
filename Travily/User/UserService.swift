import Foundation

final class UserService {
    func getUser(with login: String, handler: (User) -> Void) {
        guard let user = users.first(where: { $0.login == login }) else { return }
        handler(user)
    }
}
