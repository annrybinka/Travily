import UIKit

class ProfileViewController: UIViewController {    
    let user: User
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppСolor.forBackground
        
        ///если у метода будет @escaping то нужно добавить [weak self]
        viewModel.getUserTrips(login: user.login) { trips in
            user.trips = trips
        }
        setupTableView()
    }
    
    override func loadView() {
        super.loadView()
        view = tableView
    }
    
    private func setupTableView() {
        let headerView = ProfileHeaderView()
        headerView.configure(isCurrent: viewModel.isCurrentUser, user: user)
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
        user.trips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "TripTableViewCell",
            for: indexPath
        ) as? TripTableViewCell else {
            return UITableViewCell()
        }
        let trip = user.trips[indexPath.row]
        cell.configure(with: trip)
        
        return cell
    }
}
