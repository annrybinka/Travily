import UIKit

final class AppCoordinator {
    var window: UIWindow?
    private let userService = UserService()
    private lazy var tripStorage: TripStorage = {
        TripStorage(userService: self.userService)
    }()
    
    func startApp() {
        showMainScreen()
        //TODO: добавить авторизацию, возможно с UserDefaults внутри
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
        //TODO: заменить на UserDefaults
        //let login = UserDefaults.standard.string(forKey: "currentUserLogin")
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
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = controllers.map {
            UINavigationController(rootViewController: $0)
        }
        tabBarController.selectedIndex = 1
        
        window?.rootViewController = tabBarController
    }
}
