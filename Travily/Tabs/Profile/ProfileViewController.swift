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
        viewModel.onAlertMessageDidChange = { [weak self] message in
            self?.showAlert(message: message)
        }
    }
    
    private func showAlert(message: String) {
        let alertController = UIAlertController(
            title: nil,
            message: message,
            preferredStyle: .alert
        )
        let sendAction = UIAlertAction(title: "Отправить", style: .default) {_ in
            guard let text = alertController.textFields?.first?.text else { return }
            if text != "" {
                print("Отправлено сообщение: \(text)")
            }
        }
        let cancelAction = UIAlertAction(title: "Отменить", style: .default) {_ in }
        alertController.addAction(sendAction)
        alertController.addAction(cancelAction)
        alertController.addTextField()
        present(alertController, animated: true)
    }
    
    private func setupTableView() {
        let headerView = ProfileHeaderView()
        guard let userData = viewModel.getUserData() else { return }
        headerView.configure(isCurrentUser: viewModel.isCurrentUser, userData: userData)
        headerView.delegate = viewModel
        headerView.bounds.size.height = 250
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = UIView()
        tableView.register(
            TripTableViewCell.self,
            forCellReuseIdentifier: TripTableViewCell.id
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
            withIdentifier: TripTableViewCell.id,
            for: indexPath
        ) as? TripTableViewCell else {
            return UITableViewCell()
        }
        ///назначаем делегата и тэг для ячейки, чтобы обрабатывать действия при нажатии на разные элементы вью
        cell.set(delegate: self, tag: indexPath.row)
        ///подгатавливаем данные для наполнения ячейки и конфигурируем ячейку
        let trip = userTrips[indexPath.row]
        let author = viewModel.getUserData()
        cell.configure(
            trip: trip,
            authorName: author?.fullName ?? "",
            avatar: author?.avatar ?? UIImage(),
            isMine: viewModel.isCurrentUser,
            isFavorite: viewModel.isFavorite(tripId: trip.id),
            isLiked: viewModel.isLiked(tripId: trip.id),
            likesNumber: viewModel.getLikesNumber(tripId: trip.id)
        )
        return cell
    }
}

extension ProfileViewController: TripCellViewDelegate {
    func onAuthorTap(in view: TripCellView) {
        tableView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: true)
    }
    
    func onXmarkTap(in view: TripCellView) {
        let index = view.tag
        viewModel.deleteTrip(tripIndex: index)
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
