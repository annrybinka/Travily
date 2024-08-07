import UIKit

final class MainCoordinator {
    private let appCoordinator: AppCoordinator
    private var startViewController: UIViewController?
    
    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }
    
    func startView() -> UIViewController {
        //TODO: собрать allTrips из поездок юзеров на которых подписан = fibsTrips + rossTrips + rachelTrips
        
        let trips = allTrips.sorted { $0.id > $1.id }
        let viewModel = MainViewModel(coordinator: self, trips: trips)
        let vc = MainViewController(viewModel: viewModel)
        vc.tabBarItem = UITabBarItem(
            title: "Лента путешествий",
            image: UIImage(systemName: "globe"),
            tag: 0
        )
        startViewController = vc
        
        return vc
    }
    
    func openPage(user: User) {
        startViewController?.navigationController?.pushViewController(appCoordinator.getProfilePage(user: user), animated: true)
    }
}
