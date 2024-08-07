import UIKit

final class AppCoordinator {
    var window: UIWindow?
    
    func startApp() {
//        showPasswordScreen()
        showMainScreen()
    }
    
    func getProfilePage(user: User) -> UIViewController {
        let profileCoordinator = ProfileCoordinator()
        let userPage = profileCoordinator.getProfilePage(user: user)
        
        return userPage
    }
    
    private func showPasswordScreen() {
//        let passwordCoordinator = PasswordCoordinator()
//        passwordCoordinator.appCoordinator = self
//        let vc = passwordCoordinator.startView()
//        window?.rootViewController = vc
    }
    
    private func showMainScreen() {
        let mainCoordinator = MainCoordinator(appCoordinator: self)
        let profileCoordinator = ProfileCoordinator()
        let favoritesCoordinator = FavoritesCoordinator()
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
