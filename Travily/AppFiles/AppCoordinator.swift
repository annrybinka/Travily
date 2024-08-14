import UIKit

final class AppCoordinator {
    var window: UIWindow?
    private var tabBarController = UITabBarController()
    private let userService = UserService()
    private lazy var tripStorage: TripStorage = {
        TripStorage(userService: self.userService)
    }()
    
    func startApp() {
        showMainScreen()
    }
    
    func goToMyProfile() {
        tabBarController.selectedIndex = 1
    }
    
    func getProfilePage(userLogin: String) -> UIViewController {
        let profileCoordinator = ProfileCoordinator(
            storage: tripStorage,
            userService: userService,
            userLogin: userLogin
        )
        let userPage = profileCoordinator.getProfilePage(userLogin: userLogin)
        
        return userPage
    }
    
    private func showMainScreen() {
        var login = ""
        userService.getCurrentUser { user in
            login = user.login
        }
        let mainCoordinator = MainCoordinator(
            appCoordinator: self,
            storage: tripStorage,
            userService: userService
        )
        let profileCoordinator = ProfileCoordinator(
            storage: tripStorage,
            userService: userService,
            userLogin: login
        )
        let favoritesCoordinator = FavoritesCoordinator(
            appCoordinator: self,
            storage: tripStorage,
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
