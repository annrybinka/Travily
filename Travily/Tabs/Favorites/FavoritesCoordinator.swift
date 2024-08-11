import UIKit

final class FavoritesCoordinator {
    private let appCoordinator: AppCoordinator
    private let storage: TripStorage
    private let userService: UserService
    private var startViewController: UIViewController?
    
    init(appCoordinator: AppCoordinator, storage: TripStorage, userService: UserService) {
        self.appCoordinator = appCoordinator
        self.storage = storage
        self.userService = userService
    }
    
    func startView() -> UIViewController {
        let vm = FavoritesViewModel(coordinator: self, storage: storage, userService: userService)
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
        startViewController?.navigationController?.pushViewController(appCoordinator.getProfilePage(userLogin: userLogin), animated: true)
    }
}
