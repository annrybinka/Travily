import UIKit

///Вью со всем содержимым для ячейки с путешествием
final class TripCellView: UIView {
    private lazy var authorStackView = UserHeaderStackView()

    private lazy var tripTitleLabel = TripLabel(style: .smallLightText, text: StringConstant.destination)
    private lazy var periodTitleLabel = TripLabel(style: .smallLightText, text: StringConstant.date)
    private lazy var tripDestinationLabel = TripLabel(style: .mediumText)
    private lazy var tripPeriodLabel = TripLabel(style: .mediumText)
    
    private lazy var destinationStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = Spacing.small.rawValue
        view.addArrangedSubview(tripTitleLabel)
        view.addArrangedSubview(tripDestinationLabel)
        
        return view
    }()
    
    private lazy var periodStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = Spacing.small.rawValue
        view.addArrangedSubview(periodTitleLabel)
        view.addArrangedSubview(tripPeriodLabel)
        
        return view
    }()
    
    private lazy var tripStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
//        view.spacing = Spacing.base.rawValue
        view.addArrangedSubview(destinationStackView)
        view.addArrangedSubview(periodStackView)
        
        return view
    }()
    
    private lazy var headerStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = Spacing.base.rawValue
        view.addArrangedSubview(authorStackView)
        view.addArrangedSubview(tripStackView)
        
        return view
    }()
    
    private lazy var photoStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = Spacing.small.rawValue
        
        return view
    }()
    
    private lazy var aboutTripLabel = TripLabel(style: .smallLightText)
    
    private lazy var delimiter: UIView = {
        let view = UIView()
        view.backgroundColor = AppСolor.lightGray
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
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.addArrangedSubview(likeImageView)
        view.addArrangedSubview(markImageView)
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(trip: Trip) {
        guard let author = trip.author else { return }
        authorStackView.configure(user: author)
        
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
    
    private func setupView() {
        backgroundColor = AppСolor.forSecondBackground
        layer.cornerRadius = Spacing.doubleBase.rawValue
        clipsToBounds = true
        
        addSubview(headerStackView)
        addSubview(photoStackView)
        addSubview(aboutTripLabel)
        addSubview(delimiter)
        addSubview(actionsStackView)
        
        aboutTripLabel.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        photoStackView.translatesAutoresizingMaskIntoConstraints = false
        actionsStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                headerStackView.topAnchor.constraint(
                    equalTo: topAnchor,
                    constant: Spacing.base.rawValue
                ),
                headerStackView.leadingAnchor.constraint(
                    equalTo: leadingAnchor,
                    constant: Spacing.base.rawValue
                ),
                headerStackView.trailingAnchor.constraint(
                    equalTo: trailingAnchor,
                    constant: -Spacing.base.rawValue
                ),
                photoStackView.topAnchor.constraint(
                    equalTo: headerStackView.bottomAnchor,
                    constant: Spacing.small.rawValue
                ),
                photoStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                photoStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
                
                aboutTripLabel.topAnchor.constraint(
                    equalTo: photoStackView.bottomAnchor,
                    constant: Spacing.base.rawValue
                ),
                aboutTripLabel.leadingAnchor.constraint(
                    equalTo: leadingAnchor,
                    constant: Spacing.doubleBase.rawValue
                ),
                aboutTripLabel.trailingAnchor.constraint(
                    equalTo: trailingAnchor,
                    constant: -Spacing.doubleBase.rawValue
                ),
                delimiter.topAnchor.constraint(
                    equalTo: aboutTripLabel.bottomAnchor,
                    constant: Spacing.doubleBase.rawValue
                ),
                delimiter.leadingAnchor.constraint(equalTo: leadingAnchor),
                delimiter.trailingAnchor.constraint(equalTo: trailingAnchor),
                
                actionsStackView.topAnchor.constraint(
                    equalTo: delimiter.bottomAnchor,
                    constant: Spacing.base.rawValue
                ),
                actionsStackView.leadingAnchor.constraint(
                    equalTo: leadingAnchor,
                    constant: Spacing.big.rawValue
                ),
                actionsStackView.trailingAnchor.constraint(
                    equalTo: trailingAnchor,
                    constant: -Spacing.big.rawValue
                ),
                actionsStackView.bottomAnchor.constraint(
                    equalTo: bottomAnchor,
                    constant: -Spacing.base.rawValue
                )
            ]
        )
    }
}
