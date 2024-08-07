import Foundation

final class ProfileViewModel {
    //TODO: нужен ли здесь coordinator ?
    private let coordinator: ProfileCoordinator
    let isCurrentUser: Bool
    let storage = UserTripsStorage()
    
    init(coordinator: ProfileCoordinator, isCurrentUser: Bool) {
        self.coordinator = coordinator
        self.isCurrentUser = isCurrentUser
    }
    
    //TODO: нужен ли здесь @escaping у handler ?
    func getUserTrips(login: String, handler: ([Trip]) -> Void) {
        handler(storage.getTrips(userLogin: login))
    }
}
