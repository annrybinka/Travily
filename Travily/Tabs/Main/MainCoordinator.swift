import UIKit

final class MainCoordinator {
    private let appCoordinator: AppCoordinator
    private let userService: TripUserService
    private var startViewController: UIViewController?
    
    init(appCoordinator: AppCoordinator, userService: TripUserService) {
        self.appCoordinator = appCoordinator
        self.userService = userService
    }
    
    func startView() -> UIViewController {
        let vm = MainViewModel(coordinator: self, userService: userService)
        let vc = MainViewController(viewModel: vm)
        vc.tabBarItem = UITabBarItem(
            title: StringConstant.TabBarTitle.main,
            image: UIImage(systemName: "globe"),
            tag: 0
        )
        self.startViewController = vc

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
