import UIKit

final class FavoritesCoordinator {
    private let appCoordinator: AppCoordinator
    private let userService: TripUserService
    private var startViewController: UIViewController?
    
    init(appCoordinator: AppCoordinator, userService: TripUserService) {
        self.appCoordinator = appCoordinator
        self.userService = userService
    }
    
    func startView() -> UIViewController {
        let vm = FavoritesViewModel(coordinator: self, userService: userService)
        let vc = FavoritesViewController(viewModel: vm)
        vc.tabBarItem = UITabBarItem(
            title: StringConstant.TabBarTitle.favorites,
            image: UIImage(systemName: "bookmark"),
            tag: 2
        )
        startViewController = vc
        
        return vc
    }
    
    func openPage(userLogin: String) {
        if userService.isCurrentUser(login: userLogin) {
            appCoordinator.goToMyProfile()
        } else {
            startViewController?.navigationController?.pushViewController(appCoordinator.getProfilePage(userLogin: userLogin), animated: true)
        }
    }
}
