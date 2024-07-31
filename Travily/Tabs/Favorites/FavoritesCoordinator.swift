import UIKit

final class FavoritesCoordinator {
    func startView() -> UIViewController {
        let vc = FavoritesViewController()
        vc.tabBarItem = UITabBarItem(
            title: "Сохранённое",
            image: UIImage(systemName: "bookmark"),
            tag: 2
        )
        
        return vc
    }
}
