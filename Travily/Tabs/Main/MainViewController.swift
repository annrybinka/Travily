import UIKit

class MainViewController: UIViewController {
    private let viewModel: MainViewModel
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .null, style: .plain)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.estimatedRowHeight = 100
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
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.navigationBar.isHidden = true
//        tableView.indexPathsForSelectedRows?.forEach{ indexPath in
//            tableView.deselectRow(
//                at: indexPath,
//                animated: animated
//            )
//        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = tabBarItem.title
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = AppСolor.forBackground
        
        tableView.register(
            TripTableViewCell.self,
            forCellReuseIdentifier: "TripTableViewCell"
        )
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func loadView() {
        super.loadView()
        view = tableView
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.trips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "TripTableViewCell", 
            for: indexPath
        ) as? TripTableViewCell else {
            return UITableViewCell()
        }
        let trip = viewModel.trips[indexPath.row]
        cell.configure(with: trip)
        cell.viewForCell.authorStackView.delegate = self
        cell.viewForCell.authorStackView.tag = indexPath.row
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("=== cell tapped")
    }
}

extension MainViewController: UserHeaderStackViewDelegate {
    func onTap(in stack: UserHeaderStackView) {
        let index = stack.tag
        let trip = viewModel.trips[index]
        guard let user = trip.author else { return }
        viewModel.goToPage(user: user)
    }
}
