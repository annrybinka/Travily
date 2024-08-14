import UIKit

final class MainViewController: UIViewController {
    private let viewModel: MainViewModel
    private var trips: [Trip] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .null, style: .plain)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        
        return tableView
    }()
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        viewModel.updateFeedTrips()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = tabBarItem.title
        view.backgroundColor = AppСolor.forBackground
        bindViewModel()
        setupTableView()
    }
    
    override func loadView() {
        super.loadView()
        view = tableView
    }
    
    private func bindViewModel() {
        viewModel.onUsersTripsDidChange = { [weak self] trips in
            self?.trips = trips
            self?.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        tableView.register(
            TripTableViewCell.self,
            forCellReuseIdentifier: TripTableViewCell.id
        )
        tableView.dataSource = self
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        trips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TripTableViewCell.id, 
            for: indexPath
        ) as? TripTableViewCell else {
            return UITableViewCell()
        }
        ///назначаем делегата и тэг для ячейки, чтобы обрабатывать действия при нажатии на разные элементы вью
        cell.set(delegate: self, tag: indexPath.row)
        ///подгатавливаем данные для наполнения ячейки и конфигурируем ячейку
        let trip = trips[indexPath.row]
        let author = viewModel.getUserData(login: trip.userLogin)
        cell.configure(
            with: trip,
            isFavorite: viewModel.isFavorite(tripId: trip.id),
            isLiked: viewModel.isLiked(tripId: trip.id),
            likesNumber: viewModel.getLikesNumber(tripId: trip.id),
            authorName: author?.fullName ?? "",
            avatar: author?.avatar ?? UIImage()
        )
        return cell
    }
}

extension MainViewController: TripCellViewDelegate {
    func onAuthorTap(in view: TripCellView) {
        let index = view.tag
        viewModel.goToAuthorPage(tripIndex: index)
    }
    
    func onLikeTap(in view: TripCellView) {
        let index = view.tag
        viewModel.changeLikeStatus(tripIndex: index)
    }
    
    func onMarkTap(in view: TripCellView) {
        let index = view.tag
        viewModel.changeFavoriteStatus(tripIndex: index)
    }
}
