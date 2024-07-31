import UIKit

final class TripCellView: UIView {
    //добавить таргеты и экшоны
    
    private static let imageHeight = 60
    
     lazy var authorImage: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = CGFloat(TripCellView.imageHeight/2)
        view.contentMode = .scaleAspectFill
        view.backgroundColor = AppСolor.forBackground
        
        return view
    }()
    
    //жирный 16 текст для имени юзера
    private lazy var authorNameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        view.textColor = AppСolor.forText
        view.numberOfLines = 0
        
        return view
    }()
    
    private lazy var authorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(authorImage)
        stackView.addArrangedSubview(authorNameLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
//        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        
        return stackView
    }()
    
    //мини текст
    private lazy var tripTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "📍место"
        view.font = UIFont.systemFont(ofSize: 12, weight: .light)
        view.textColor = AppСolor.forText
        view.numberOfLines = 1
        
        return view
    }()
    
    private lazy var periodTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "📅 даты поездки"
        view.font = UIFont.systemFont(ofSize: 12, weight: .light)
        view.textColor = AppСolor.forText
        view.numberOfLines = 1
        
        return view
    }()
    
    //Крупный текст
    private lazy var tripDestinationLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        view.textColor = AppСolor.forText
        view.numberOfLines = 0
        
        return view
    }()
    
    private lazy var tripPeriodLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        view.textColor = AppСolor.forText
        view.numberOfLines = 0
        
        return view
    }()
    
    private lazy var destinationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(tripTitleLabel)
        stackView.addArrangedSubview(tripDestinationLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
//        stackView.distribution = .equalCentering
        stackView.spacing = 3
        
        return stackView
    }()
    
    private lazy var periodStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(periodTitleLabel)
        stackView.addArrangedSubview(tripPeriodLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
//        stackView.distribution = .fillEqually
        stackView.spacing = 3
        
        return stackView
    }()
    
    private lazy var tripStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(destinationStackView)
        stackView.addArrangedSubview(periodStackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        
        return stackView
    }()
    
    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(authorStackView)
        stackView.addArrangedSubview(tripStackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
//        stackView.layer.cornerRadius = 6
//        stackView.backgroundColor = AppСolor.forSecondBackground
        
        return stackView
    }()
    
    private lazy var photoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 3
        
        return stackView
    }()
    
    //мини текст
    private lazy var aboutTripLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 12, weight: .light)
        view.textColor = AppСolor.forSecondText
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var delimiter: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var likeImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "hand.thumbsup")
        view.tintColor = AppСolor.forText
        
        return view
    }()
    
    private lazy var markImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "bookmark")
        view.tintColor = AppСolor.forText
        
        return view
    }()
    
    private lazy var actionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(likeImageView)
        stackView.addArrangedSubview(markImageView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with trip: Trip) {
        guard let author = users.first(where: { user in
            user.login == trip.userLogin
        }) else { return }
        authorImage.image = author.avatar
        authorNameLabel.text = author.fullName
        tripDestinationLabel.text = trip.destination
        tripPeriodLabel.text = trip.period
        aboutTripLabel.text = trip.about
        photoStackView.arrangedSubviews.forEach {$0.removeFromSuperview()}
        for image in trip.images {
            let view = UIImageView()
            view.image = image
            view.contentMode = .scaleAspectFill
            view.clipsToBounds = true
            view.heightAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            photoStackView.addArrangedSubview(view)
        }
    }
    
    private func setupUI() {
        backgroundColor = AppСolor.forSecondBackground
        addSubview(headerStackView)
        addSubview(photoStackView)
        addSubview(aboutTripLabel)
        addSubview(delimiter)
        addSubview(actionsStackView)
        
        NSLayoutConstraint.activate(
            [
                authorImage.heightAnchor.constraint(equalToConstant: CGFloat(TripCellView.imageHeight)),
                authorImage.widthAnchor.constraint(equalToConstant: CGFloat(TripCellView.imageHeight)),

                headerStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                headerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                headerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
                
                photoStackView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 3),
                photoStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                photoStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
                
                aboutTripLabel.topAnchor.constraint(equalTo: photoStackView.bottomAnchor, constant: 8),
                aboutTripLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                aboutTripLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                
//                delimiter.topAnchor.constraint(equalTo: aboutTripLabel.bottomAnchor, constant: 8),
//                delimiter.leadingAnchor.constraint(equalTo: leadingAnchor),
//                delimiter.trailingAnchor.constraint(equalTo: trailingAnchor),
//                
//                actionsStackView.topAnchor.constraint(equalTo: delimiter.bottomAnchor, constant: 8),
//                actionsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//                actionsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                aboutTripLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
            ]
        )
    }
}
