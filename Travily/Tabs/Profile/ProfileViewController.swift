import UIKit

class ProfileViewController: UIViewController {    
    var user: User
    var userTrips: [Trip] = []
    private let viewModel: ProfileViewModel
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .null, style: .plain)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        
        return tableView
    }()
    
    init(user: User, viewModel: ProfileViewModel) {
        self.user = user
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        viewModel.onViewWillAppear(userLogin: user.login)
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
        }
    }
    
    private func setupTableView() {
        let headerView = ProfileHeaderView()
        headerView.configure(
            isCurrent: viewModel.isCurrentUser,
            login: user.login,
            avatar: user.avatar,
            name: user.fullName,
            aboutMe: user.aboutMe,
            tripsNumber: userTrips.count,
            subscriptions: user.subscriptions,
            followers: user.followers
        )
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
        let trip = userTrips[indexPath.row]
        cell.configure(with: trip)
        
        ///назначаем делегата у вью ячейки и проставляем тэг, чтобы можно было перейти в профиль автора поста, поставить лайк и добавить пост в избранное
        cell.set(delegate: viewModel, tag: indexPath.row)
//        cell.viewForCell.delegate = viewModel
//        cell.viewForCell.tag = indexPath.row
        
        return cell
    }
}
