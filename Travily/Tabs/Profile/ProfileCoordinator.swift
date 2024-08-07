import UIKit

final class ProfileCoordinator {
    let currentUserLogin = "Rachel78"
    
    func startView() -> UIViewController {
        //отдать логику поиска в сервис юзеров
        let user = users.first { $0.login == currentUserLogin }
        
        let viewModel = ProfileViewModel(coordinator: self, isCurrentUser: true)
        let vc = ProfileViewController(user: user!, viewModel: viewModel)
        vc.tabBarItem = UITabBarItem(
            title: "Моя страница",
            image: UIImage(systemName: "person.crop.circle"),
            tag: 1
        )
             
        return vc
    }
    
    func getProfilePage(user: User) -> UIViewController {
        //TODO: БАГ сейчас при заходе на страницу Рейчел через ленту у неё НЕ подтягиваются поездки
        
        let isCurrentUser = (user.login == currentUserLogin)
        let viewModel = ProfileViewModel(coordinator: self, isCurrentUser: isCurrentUser)
        let vc = ProfileViewController(user: user, viewModel: viewModel)
        return vc
    }
}
