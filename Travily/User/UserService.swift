import Foundation

final class UserService {
    //TODO: currentUserLogin получать через UserDefaults
    private let currentUserLogin = "Rachel78"
    private let users = [userRachel, userFibs, userRoss, testUser]
    
    func getCurrentUser(handler: (User) -> Void) {
        guard let user = users.first(where: { $0.login == currentUserLogin }) else { return }
        handler(user)
    }
    
    func getUser(with login: String, handler: (User) -> Void) {
        guard let user = users.first(where: { $0.login == login }) else { return }
        handler(user)
    }
    
    func isCurrentUser(login: String, handler: (Bool) -> Void) {
        handler(login == currentUserLogin)
    }
}
