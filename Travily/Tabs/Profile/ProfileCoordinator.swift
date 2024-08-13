import UIKit

final class ProfileCoordinator {
    private var startViewController: UIViewController?
    private let storage: TripStorage
    private let userService: UserService
    
    init(storage: TripStorage, userService: UserService, userLogin: String) {
        self.storage = storage
        self.userService = userService
    }
    
    func startView() -> UIViewController {
        userService.getCurrentUser { user in
            let vm = ProfileViewModel(coordinator: self, storage: storage, userService: userService, userLogin: user.login)
            let vc = ProfileViewController(viewModel: vm)
            vc.tabBarItem = UITabBarItem(
                title: StringConstant.TabBarTitle.profile,
                image: UIImage(systemName: "person.crop.circle"),
                tag: 1
            )
            startViewController = vc
        }
        return startViewController ?? UIViewController()
    }
    
    //можем перейти как в профиль каррентюзера, так и его друга
    //TODO: для хэдера нужны разные делегаты? либо убирать кнопку "рассказать о поездке" если каррентюзер переходит на свою страницу, сейчас "рассказать о поездке" не работает из ленты и избранного
    func getProfilePage(userLogin: String) -> UIViewController {
        let vm = ProfileViewModel(coordinator: self, storage: storage, userService: userService, userLogin: userLogin)
        let vc = ProfileViewController(viewModel: vm)
        
        return vc
    }
    
    func showCreateTripForm(viewModel: ProfileViewModel) {
        startViewController?.present(
            CreateTripViewController(viewModel: viewModel),
            animated: true
        )
    }
    
    func presentImagePicker(delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = delegate
        startViewController?.modalTransitionStyle = .flipHorizontal
        startViewController?.modalPresentationStyle = .overCurrentContext
        startViewController?.presentedViewController?.present(imagePicker, animated: true)
    }
}
