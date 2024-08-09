import Foundation

final class ProfileViewModel {
    private let coordinator: ProfileCoordinator
    private let storage = TripStorage()
    let isCurrentUser: Bool
    
    var onUserTripsDidChange: (([Trip]) -> Void)?
    private(set) var userTrips: [Trip] = [] {
        didSet {
            onUserTripsDidChange?(userTrips)
        }
    }
    
    init(coordinator: ProfileCoordinator, isCurrentUser: Bool) {
        self.coordinator = coordinator
        self.isCurrentUser = isCurrentUser
    }
    
    func onViewWillAppear(userLogin: String) {
        storage.getAllTrips(by: [userLogin]) { trips in
            self.userTrips = trips
        }
    }
    
    func openCreateTripForm() {
        coordinator.showCreateTripForm()
    }
    
    func createNew(trip: Trip, by user: String) {
        storage.addNew(trip: trip, by: user) { result in
            print("result = \(result)")
            if result {
                self.storage.getAllTrips(by: [user]) { trips in
                    self.userTrips = trips
                }
            }
        }
    }
}

extension ProfileViewModel: TripCellViewDelegate {
    func onAuthorTap(in view: TripCellView) {
        //можно скроллить в начало или подсвечивать что уже на странице этого юзера
    }
    
    func onLikeTap(in view: TripCellView) {
        print("on Like Tap")
    }
    
    func onMarkTap(in view: TripCellView) {
        print("on Mark Tap")
        let index = view.tag
        let trip = userTrips[index]
        storage.saveFavorite(trip: trip, for: "Rachel78") { result in
            if result {
                print("trip saved")
                //обратиться к свойству поездки и покрасить закладку
            }
        }
    }
}
