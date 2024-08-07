import Foundation

final class MainViewModel {
    private let coordinator: MainCoordinator
    let trips: [Trip]
    
    init(coordinator: MainCoordinator, trips: [Trip]) {
        self.coordinator = coordinator
        self.trips = trips
    }
    
    func goToPage(user: User) {
        coordinator.openPage(user: user)
    }
}
