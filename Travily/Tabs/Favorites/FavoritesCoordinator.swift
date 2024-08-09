import UIKit

final class FavoritesCoordinator {
    private let appCoordinator: AppCoordinator
    private var startViewController: UIViewController?
    
    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }
    
    func startView() -> UIViewController {
        let vm = FavoritesViewModel(coordinator: self)
        let vc = FavoritesViewController(viewModel: vm)
        vc.tabBarItem = UITabBarItem(
            title: StringConstant.TabBarTitle.favorites,
            image: UIImage(systemName: "bookmark"),
            tag: 2
        )
        startViewController = vc
        
        return vc
    }
    
    func openPage(user: User) {
        startViewController?.navigationController?.pushViewController(appCoordinator.getProfilePage(user: user), animated: true)
    }
}
