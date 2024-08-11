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
        tableView.reloadData()
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
            forCellReuseIdentifier: "TripTableViewCell"
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
            withIdentifier: "TripTableViewCell",
            for: indexPath
        ) as? TripTableViewCell else {
            return UITableViewCell()
        }
        ///назначаем делегата у вью ячейки и проставляем тэг, чтобы можно было перейти в профиль автора поста, поставить лайк и добавить пост в избранное
        cell.set(delegate: self, tag: indexPath.row)
        
        var trip = favoriteTrips[indexPath.row]
        trip.isFavorite = true
        let author = viewModel.getUserData(login: trip.userLogin)
        cell.configure(
            with: trip,
            authorName: author?.fullName ?? "",
            avatar: author?.avatar ?? UIImage()
        )
        return cell
    }
}

extension FavoritesViewController: TripCellViewDelegate {
    func onAuthorTap(in view: TripCellView) {
        let index = view.tag
        viewModel.goToAuthorPage(tripIndex: index)
    }
    
    func onLikeTap(in view: TripCellView) {
        print("on Like Tap")
    }
    
    func onMarkTap(in view: TripCellView) {
        let index = view.tag
        viewModel.removeFromFavorites(tripIndex: index)
    }
}
