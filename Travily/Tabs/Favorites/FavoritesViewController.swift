import UIKit

final class FavoritesViewController: UIViewController {
    private let viewModel: FavoritesViewModel
    private var favoriteTrips: [Trip] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .null, style: .plain)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        
        return tableView
    }()
    
    init(viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        viewModel.updateSavedTrips()
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
        viewModel.onSavedTripsDidChange = { [weak self] trips in
            self?.favoriteTrips = trips
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

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteTrips.count
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
        let trip = favoriteTrips[indexPath.row]
        let author = viewModel.getUserData(login: trip.userLogin)
        cell.configure(
            trip: trip,
            authorName: author?.fullName ?? "",
            avatar: author?.avatar ?? UIImage(),
            isMine: false,
            isFavorite: true,
            isLiked: viewModel.isLiked(tripId: trip.id),
            likesNumber: viewModel.getLikesNumber(tripId: trip.id)
        )
        return cell
    }
}

extension FavoritesViewController: TripCellViewDelegate {
    func onAuthorTap(in view: TripCellView) {
        let index = view.tag
        viewModel.goToAuthorPage(tripIndex: index)
    }
    
    func onXmarkTap(in view: TripCellView) {
        ///в разделе "Избраноое" нет возможности удалить поездку
    }
    
    func onLikeTap(in view: TripCellView) {
        let index = view.tag
        viewModel.changeLikeStatus(tripIndex: index)
    }
    
    func onMarkTap(in view: TripCellView) {
        let index = view.tag
        viewModel.removeFromFavorites(tripIndex: index)
    }
}
