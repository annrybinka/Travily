import UIKit

///for Trip Cell View
/*
final class TripTableViewCell: UITableViewCell {
    private lazy var viewForBackground: UIView = {
        let view = UIView()
        view.backgroundColor = AppСolor.forSecondBackground
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    func setBackground(view: UIView) {
        viewForBackground = view
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = AppСolor.forBackground
        contentView.addSubview(viewForBackground)
        NSLayoutConstraint.activate(
            [
                viewForBackground.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                viewForBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                viewForBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                viewForBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
            ]
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
*/

final class TripTableViewCell: UITableViewCell {
    
    private lazy var viewForBackground: UIView = {
        let view = UIView()
        view.backgroundColor = AppСolor.forSecondBackground
        view.layer.cornerRadius = Spacing.doubleBase.rawValue
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    private lazy var authorImage: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = TripConstants.avatarSize/2
        view.contentMode = .scaleAspectFill
        view.backgroundColor = AppСolor.forBackground
        
        return view
    }()
    
    private lazy var authorNameLabel = TripLabel(style: .boldTitle)
    
    private lazy var authorStackView = TripStackView(
        subviews: [authorImage, authorNameLabel],
        axis: .horizontal,
        spacing: .base
    )
    private lazy var tripTitleLabel = TripLabel(style: .smallLight, text: "📍место")
    private lazy var periodTitleLabel = TripLabel(style: .smallLight, text: "🗓 дата поездки")
    private lazy var tripDestinationLabel = TripLabel(style: .mediumText)
    private lazy var tripPeriodLabel = TripLabel(style: .mediumText)
    
    private lazy var destinationStackView = TripStackView(
        subviews: [tripTitleLabel, tripDestinationLabel],
        axis: .vertical,
        spacing: .small
    )
    private lazy var periodStackView = TripStackView(
        subviews: [periodTitleLabel, tripPeriodLabel],
        axis: .vertical,
        spacing: .small
    )
    private lazy var tripStackView = TripStackView(
        subviews: [destinationStackView, periodStackView],
        axis: .horizontal,
        spacing: .base
    )
    private lazy var headerStackView = TripStackView(
        subviews: [authorStackView, tripStackView],
        axis: .vertical,
        spacing: .base
    )
    private lazy var photoStackView = TripStackView(
        subviews: [],
        axis: .horizontal,
        spacing: .small
    )
    private lazy var aboutTripLabel = TripLabel(style: .smallLight)
    
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
    
    private lazy var actionsStackView = TripStackView(
        subviews: [likeImageView, markImageView],
        axis: .horizontal,
        distribution: .equalSpacing
    )
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        contentView.backgroundColor = AppСolor.forBackground
        contentView.addSubview(viewForBackground)
        viewForBackground.addSubview(headerStackView)
        viewForBackground.addSubview(photoStackView)
        viewForBackground.addSubview(aboutTripLabel)
        viewForBackground.addSubview(delimiter)
        viewForBackground.addSubview(actionsStackView)
        aboutTripLabel.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        photoStackView.translatesAutoresizingMaskIntoConstraints = false
        actionsStackView.translatesAutoresizingMaskIntoConstraints = false
        
///        for UIView+extention
//        viewForBackground.setConstraints(
//            top: UIView.ConstraintY(equalTo: contentView.topAnchor, constant: .base),
//            leading: UIView.ConstraintX(equalTo: contentView.leadingAnchor, constant: nil),
//            trailing: UIView.ConstraintX(equalTo: contentView.trailingAnchor, constant: nil),
//            bottom: UIView.ConstraintY(equalTo: contentView.bottomAnchor, constant: .baseWithMinus)
//        )
        
        NSLayoutConstraint.activate(
            [
                viewForBackground.topAnchor.constraint(
                    equalTo: contentView.topAnchor,
                    constant: Spacing.base.rawValue
                ),
                viewForBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                viewForBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                viewForBackground.bottomAnchor.constraint(
                    equalTo: contentView.bottomAnchor,
                    constant: -Spacing.base.rawValue
                ),
                authorImage.heightAnchor.constraint(equalToConstant: TripConstants.avatarSize),
                authorImage.widthAnchor.constraint(equalToConstant: TripConstants.avatarSize),

                headerStackView.topAnchor.constraint(
                    equalTo: viewForBackground.topAnchor,
                    constant: Spacing.base.rawValue
                ),
                headerStackView.leadingAnchor.constraint(
                    equalTo: viewForBackground.leadingAnchor,
                    constant: Spacing.base.rawValue
                ),
                headerStackView.trailingAnchor.constraint(
                    equalTo: viewForBackground.trailingAnchor,
                    constant: -Spacing.base.rawValue
                ),
                photoStackView.topAnchor.constraint(
                    equalTo: headerStackView.bottomAnchor,
                    constant: Spacing.small.rawValue
                ),
                photoStackView.leadingAnchor.constraint(equalTo: viewForBackground.leadingAnchor),
                photoStackView.trailingAnchor.constraint(equalTo: viewForBackground.trailingAnchor),
                
                aboutTripLabel.topAnchor.constraint(
                    equalTo: photoStackView.bottomAnchor,
                    constant: Spacing.base.rawValue
                ),
                aboutTripLabel.leadingAnchor.constraint(
                    equalTo: viewForBackground.leadingAnchor,
                    constant: Spacing.doubleBase.rawValue
                ),
                aboutTripLabel.trailingAnchor.constraint(
                    equalTo: viewForBackground.trailingAnchor,
                    constant: -Spacing.doubleBase.rawValue
                ),
                delimiter.topAnchor.constraint(
                    equalTo: aboutTripLabel.bottomAnchor,
                    constant: Spacing.doubleBase.rawValue
                ),
                delimiter.leadingAnchor.constraint(equalTo: viewForBackground.leadingAnchor),
                delimiter.trailingAnchor.constraint(equalTo: viewForBackground.trailingAnchor),
                
                actionsStackView.topAnchor.constraint(
                    equalTo: delimiter.bottomAnchor,
                    constant: Spacing.base.rawValue
                ),
                actionsStackView.leadingAnchor.constraint(
                    equalTo: viewForBackground.leadingAnchor,
                    constant: Spacing.big.rawValue
                ),
                actionsStackView.trailingAnchor.constraint(
                    equalTo: viewForBackground.trailingAnchor,
                    constant: -Spacing.big.rawValue
                ),
                actionsStackView.bottomAnchor.constraint(
                    equalTo: viewForBackground.bottomAnchor,
                    constant: -Spacing.base.rawValue
                )
            ]
        )
    }
}
