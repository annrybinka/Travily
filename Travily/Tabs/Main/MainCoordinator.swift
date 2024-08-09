import UIKit

final class MainCoordinator {
    private let appCoordinator: AppCoordinator
    private var startViewController: UIViewController?
    
    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }
    
    func startView() -> UIViewController {
        let vm = MainViewModel(coordinator: self)
        let vc = MainViewController(viewModel: vm)
        vc.tabBarItem = UITabBarItem(
            title: StringConstant.TabBarTitle.main,
            image: UIImage(systemName: "globe"),
            tag: 0
        )
        self.startViewController = vc

        return vc
    }
    
    func openPage(user: User) {
        startViewController?.navigationController?.pushViewController(appCoordinator.getProfilePage(user: user), animated: true)
    }
}
