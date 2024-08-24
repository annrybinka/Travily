import UIKit
import RealmSwift

final class AppCoordinator {
    var window: UIWindow?
    private var tabBarController = UITabBarController()
    private let userService = TripUserService()
    
    func startApp() {
        guard UserDefaults.standard.string(forKey: "currentUserLogin") != nil else {
            UserDefaults.standard.setValue(
                userService.currentUserLogin,
                forKey: "currentUserLogin"
            )
            addStaticInfoToRealm()
            showMainScreen()
            return
        }
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
    
    private func addStaticInfoToRealm() {
        do {
            let realm = try Realm()
            let users = LocalStorage().getLocalUsers()
            let trips = LocalStorage().getLocalTrips()
            
            if realm.isInWriteTransaction {
                users.forEach {
                    realm.create(UserRealm.self, value: $0.keyedValues)
                }
                trips.forEach {
                    realm.create(TripRealm.self, value: $0.keyedValues)
                }
            } else {
                try realm.write {
                    users.forEach {
                        realm.create(UserRealm.self, value: $0.keyedValues)
                    }
                    trips.forEach {
                        realm.create(TripRealm.self, value: $0.keyedValues)
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func rebootRealm() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print(error.localizedDescription)
        }
        addStaticInfoToRealm()
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
