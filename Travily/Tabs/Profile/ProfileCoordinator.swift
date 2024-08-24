import UIKit

final class ProfileCoordinator {
    private let userService: TripUserService
    private var startViewController: UIViewController?
    
    init(userService: TripUserService) {
        self.userService = userService
    }
    
    func startView() -> UIViewController {
        userService.getCurrentUser { user in
            let vm = ProfileViewModel(
                coordinator: self,
                userService: self.userService,
                userLogin: user.login
            )
            let vc = ProfileViewController(viewModel: vm)
            vc.tabBarItem = UITabBarItem(
                title: StringConstant.TabBarTitle.profile,
                image: UIImage(systemName: "person.crop.circle"),
                tag: 1
            )
            self.startViewController = vc
        }
        return startViewController ?? UIViewController()
    }
    
    ///метод для перехода в профили юзеров из ленты или избранного
    func getProfilePage(userLogin: String) -> UIViewController {
        let vm = ProfileViewModel(
            coordinator: self,
            userService: userService,
            userLogin: userLogin
        )
        let vc = ProfileViewController(viewModel: vm)
        
        return vc
    }
    
    ///открываем модальное окно с формой для создания поездки
    func showCreateTripForm(viewModel: ProfileViewModel) {
        startViewController?.present(
            CreateTripViewController(viewModel: viewModel),
            animated: true
        )
    }
    
    func presentImagePicker(
        delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate
    ) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = delegate
        startViewController?.presentedViewController?.present(imagePicker, animated: true)
    }
}
