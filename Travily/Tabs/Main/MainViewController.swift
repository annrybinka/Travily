import UIKit

class MainViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .null, style: .plain)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        return tableView
    }()
    
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
        allTrips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "TripTableViewCell", 
            for: indexPath
        ) as? TripTableViewCell else {
            return UITableViewCell()
        }
        let trip = allTrips[indexPath.row]
        cell.configure(with: trip)
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("=== cell tapped")
    }
}
