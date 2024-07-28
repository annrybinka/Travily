import UIKit

final class ProfileCoordinator {
    func startView() -> UIViewController {
        let vc = ProfileViewController()
        vc.tabBarItem = UITabBarItem(
            title: "Профиль",
            image: UIImage(systemName: "person.crop.circle"),
            tag: 1
        )
        
        return vc
    }
}
