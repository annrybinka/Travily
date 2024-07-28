import UIKit

final class MainCoordinator {
    func startView() -> UIViewController {
        let vc = MainViewController()
        vc.tabBarItem = UITabBarItem(
            title: "Главная",
            image: UIImage(systemName: "house"),
            tag: 0
        )
        
        return vc
    }
}
