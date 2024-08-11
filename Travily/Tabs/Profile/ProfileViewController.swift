import UIKit

final class ProfileViewController: UIViewController {
    private let viewModel: ProfileViewModel
    private var userTrips: [Trip] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .null, style: .plain)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        
        return tableView
    }()
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        viewModel.updateUserTrips()
        tableView.reloadData()
        setupTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppСolor.forBackground
        bindViewModel()
        
    }
    
    override func loadView() {
        super.loadView()
        view = tableView
    }
    
    private func bindViewModel() {
        viewModel.onUserTripsDidChange = { [weak self] trips in
            self?.userTrips = trips
            self?.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        let headerView = ProfileHeaderView()
        headerView.delegate = viewModel
        guard let userData = viewModel.getUserData() else { return }
        headerView.configure(isCurrentUser: true, userData: userData)
        headerView.bounds.size.height = 250
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = UIView()
        tableView.register(
            TripTableViewCell.self,
            forCellReuseIdentifier: "TripTableViewCell"
        )
        tableView.dataSource = self
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userTrips.count
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
        
        let trip = userTrips[indexPath.row]
        let author = viewModel.getUserData()
        cell.configure(
            with: trip,
            isFavorite: viewModel.isFavorite(tripId: trip.id),
            authorName: author?.fullName ?? "",
            avatar: author?.avatar ?? UIImage()
        )
        return cell
    }
}

extension ProfileViewController: TripCellViewDelegate {
    func onAuthorTap(in view: TripCellView) {
        //TODO: можно скроллить в начало или подсвечивать что уже на странице этого юзера
    }
    
    func onLikeTap(in view: TripCellView) {
        print("on Like Tap")
    }
    
    func onMarkTap(in view: TripCellView) {
        let index = view.tag
        viewModel.addToFavorites(tripIndex: index)
    }
}
