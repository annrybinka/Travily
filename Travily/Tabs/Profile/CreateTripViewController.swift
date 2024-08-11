import UIKit

final class CreateTripViewController: UIViewController {
    private let viewModel: ProfileViewModel
    
    private lazy var button = ProfileButton(title: "Опубликовать поездку") {
        let trip = Trip(
            id: 10,
            userLogin: "Rachel78",
            destination: "Караганда",
            period: "1984 год",
            about: nil,
            images: []
        )
        self.viewModel.createNew(trip: trip)
        
        //+ закрыть контроллер
    }
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppСolor.forBackground
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(button)
        let safeAreaGuide = view.safeAreaLayoutGuide
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                button.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
                button.centerYAnchor.constraint(equalTo: safeAreaGuide.centerYAnchor)
            ]
        )
    }
}
