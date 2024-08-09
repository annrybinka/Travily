import Foundation

final class MainViewModel {
    private let coordinator: MainCoordinator
    private let storage = TripStorage()
    
    var onUsersTripsDidChange: (([Trip]) -> Void)?
    private(set) var allUsersTrips: [Trip] = [] {
        didSet {
            onUsersTripsDidChange?(allUsersTrips)
        }
    }
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
    }
    
    ///получаем посты с поездками всех, на кого подписан главный юзер
    func onViewWillAppear() {
        storage.getAllTrips(by: ["Rachel78", "doctor-ross", "thebestgirl"]) { trips in
            self.allUsersTrips = trips
        }
    }
    
    func goToPage(user: User) {
        coordinator.openPage(user: user)
    }
}

extension MainViewModel: TripCellViewDelegate {
    func onAuthorTap(in view: TripCellView) {
        let index = view.tag
        let trip = allUsersTrips[index]
        guard let user = trip.author else { return }
        goToPage(user: user)
    }
    
    func onLikeTap(in view: TripCellView) {
        print("on Like Tap")
    }
    
    func onMarkTap(in view: TripCellView) {
        print("on Mark Tap")
        let index = view.tag
        let trip = allUsersTrips[index]
        storage.saveFavorite(trip: trip, for: "Rachel78") { result in
            if result {
                print("trip saved")
                //обратиться к свойству поездки и покрасить закладку
            }
        }
    }
}
