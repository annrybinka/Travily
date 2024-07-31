import UIKit

final class MainCoordinator {
    func startView() -> UIViewController {
        let vc = MainViewController()
        vc.tabBarItem = UITabBarItem(
            title: "Лента путешествий",
            image: UIImage(systemName: "house"),
            tag: 0
        )
        
        return vc
    }
}
