import UIKit

final class ProfileCoordinator {
    private let currentUserLogin = "Rachel78"
    var currentUser: User?
    
    func startView() -> UIViewController {
        let service = UserService()
        service.getUser(with: currentUserLogin) { user in
            self.currentUser = user
        }
        let vm = ProfileViewModel(coordinator: self, isCurrentUser: true)
        let vc = ProfileViewController(user: currentUser!, viewModel: vm)
        vc.tabBarItem = UITabBarItem(
            title: StringConstant.TabBarTitle.profile,
            image: UIImage(systemName: "person.crop.circle"),
            tag: 1
        )
        return vc
    }
    
    func getProfilePage(user: User) -> UIViewController {
        let isCurrentUser = (user.login == currentUserLogin)
        let vm = ProfileViewModel(coordinator: self, isCurrentUser: isCurrentUser)
        let vc = ProfileViewController(user: user, viewModel: vm)
        return vc
    }
    
    func showCreateTripForm() {
        
    }
}
