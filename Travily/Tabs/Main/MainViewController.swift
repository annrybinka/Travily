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
        viewModel.updateAllUsersTrips()
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
            forCellReuseIdentifier: "TripTableViewCell"
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
            withIdentifier: "TripTableViewCell", 
            for: indexPath
        ) as? TripTableViewCell else {
            return UITableViewCell()
        }
        ///назначаем делегата у вью ячейки и проставляем тэг, чтобы можно было перейти в профиль автора поста, поставить лайк и добавить пост в избранное
        cell.set(delegate: self, tag: indexPath.row)
        
        let trip = trips[indexPath.row]
        let author = viewModel.getUserData(login: trip.userLogin)
        cell.configure(
            with: trip,
            isFavorite: viewModel.isFavorite(tripId: trip.id),
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
        print("on Like Tap")
    }
    
    func onMarkTap(in view: TripCellView) {
        let index = view.tag
        viewModel.changeFavoriteStatus(tripIndex: index)
    }
}
