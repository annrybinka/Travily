import UIKit
import RealmSwift

final class AppCoordinator {
    var window: UIWindow?
    private var tabBarController = UITabBarController()
    private let userService = TripUserService()
    
    private func cleanRealm() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func addAllUsersToRealm() {
        do {
            let realm = try Realm()
            let users = [userRachel, userFibs, userRoss, testUser]
            if realm.isInWriteTransaction {
                users.forEach {
                    realm.create(UserRealm.self, value: $0.keyedValues)
                }
            } else {
                try realm.write {
                    users.forEach {
                        realm.create(UserRealm.self, value: $0.keyedValues)
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func addAllTripsToRealm() {
        do {
            let realm = try Realm()
            let allTrips = rachelTrips + fibsTrips + rossTrips
            if realm.isInWriteTransaction {
                allTrips.forEach {
                    realm.create(TripRealm.self, value: $0.keyedValues)
                }
            } else {
                try realm.write {
                    allTrips.forEach {
                        realm.create(TripRealm.self, value: $0.keyedValues)
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func startApp() {
        //TODO: сделать логику с авторизацией
//        addAllUsersToRealm()
//        addAllTripsToRealm()
//        cleanRealm()
        showMainScreen()
    }
    
    func goToMyProfile() {
        tabBarController.selectedIndex = 1
    }
    
    func getProfilePage(userLogin: String) -> UIViewController {
        let profileCoordinator = ProfileCoordinator(userService: userService)
        let userPage = profileCoordinator.getProfilePage(userLogin: userLogin)
        
        return userPage
    }
    
    private func showMainScreen() {
        let mainCoordinator = MainCoordinator(
            appCoordinator: self,
            userService: userService
        )
        let profileCoordinator = ProfileCoordinator(
            userService: userService
        )
        let favoritesCoordinator = FavoritesCoordinator(
            appCoordinator: self,
            userService: userService
        )
        let controllers = [
            mainCoordinator.startView(),
            profileCoordinator.startView(),
            favoritesCoordinator.startView()
        ]
        tabBarController.viewControllers = controllers.map {
            UINavigationController(rootViewController: $0)
        }
        tabBarController.selectedIndex = 0

        window?.rootViewController = tabBarController
    }
}
