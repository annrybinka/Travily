import Foundation
    
final class FavoritesViewModel {
    private let coordinator: FavoritesCoordinator
    private let storage = TripStorage()
    private let currentUserLogin = "Rachel78"

    var onSavedTripsDidChange: (([Trip]) -> Void)?
    private(set) var savedTrips: [Trip] = [] {
        didSet {
            onSavedTripsDidChange?(savedTrips)
        }
    }
    
    init(coordinator: FavoritesCoordinator) {
        self.coordinator = coordinator
    }

    func onViewWillAppear() {
        storage.getFavoriteTrips(by: currentUserLogin) { trips in
            self.savedTrips = trips
        }
    }
    
    func goToPage(user: User) {
        coordinator.openPage(user: user)
    }
}

extension FavoritesViewModel: TripCellViewDelegate {
    func onAuthorTap(in view: TripCellView) {
        let index = view.tag
        let trip = savedTrips[index]
        guard let user = trip.author else { return }
        goToPage(user: user)
    }
    
    func onLikeTap(in view: TripCellView) {
        print("on Like Tap")
    }
    
    func onMarkTap(in view: TripCellView) {
        print("on Mark Tap")
        let index = view.tag
        storage.removeFavoriteTrip(with: index, for: "Rachel78") { result in
            if result {
                print("trip deleted")
            }
        }
        onViewWillAppear()
    }
}
