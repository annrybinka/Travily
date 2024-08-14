import Foundation

final class UserService {
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
    
    func isCurrentUser(login: String) -> Bool {
        login == currentUserLogin
    }
    
    ///проверяем кто ставил лайк поездке среди всех юзеров
    func getUsersLiked(tripId: String, handler: ([String]) -> Void) {
        var result: [String] = []
        users.forEach { user in
            if user.likedTrips.contains(where: { $0 == tripId }) {
                result.append(user.login)
            }
        }
        handler(result)
    }
}
