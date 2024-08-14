import UIKit

protocol TripCellViewDelegate: AnyObject {
    func onAuthorTap(in view: TripCellView)
    func onLikeTap(in view: TripCellView)
    func onMarkTap(in view: TripCellView)
}

///Вью со всем содержимым для ячейки с путешествием, а делегат помогает обрабатывать нажатия на разные элементы вью
final class TripCellView: UIView {
    weak var delegate: TripCellViewDelegate?
    
    private lazy var authorStackView = UserHeaderStackView()
    private lazy var tripTitleLabel = TripLabel(
        style: .smallLightText,
        text: StringConstant.destination
    )
    private lazy var periodTitleLabel = TripLabel(
        style: .smallLightText, 
        text: StringConstant.date
    )
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
        
        return view
    }()
    
    private lazy var likeImageView: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    private lazy var likesLabel = TripLabel(style: .mediumText, text: nil)
    
    private lazy var markImageView: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    private lazy var actionsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.addArrangedSubview(likeImageView)
        view.setCustomSpacing(Spacing.small.rawValue, after: likeImageView)
        view.addArrangedSubview(likesLabel)
        view.addArrangedSubview(UIView())
        view.addArrangedSubview(markImageView)
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addGestureRecognizer()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///Добавляем обработку нажатий на разные элементы вью
    private func addGestureRecognizer() {
        let tapOnAuthorGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnAuthor))
        authorStackView.addGestureRecognizer(tapOnAuthorGesture)
        
        let tapOnLikeGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnLike))
        likeImageView.addGestureRecognizer(tapOnLikeGesture)
        
        let tapOnMarkGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnMark))
        markImageView.addGestureRecognizer(tapOnMarkGesture)
    }
    
    @objc private func tapOnAuthor(sender: UILongPressGestureRecognizer) {
        delegate?.onAuthorTap(in: self)
    }
    
    @objc private func tapOnLike(sender: UILongPressGestureRecognizer) {
        delegate?.onLikeTap(in: self)
    }
    
    @objc private func tapOnMark(sender: UILongPressGestureRecognizer) {
        delegate?.onMarkTap(in: self)
    }
    
    ///Наполняем вью информацией о поездке
    func configure(
        trip: Trip,
        isFavorite: Bool,
        isLiked: Bool,
        likesNumber: Int,
        authorName: String,
        avatar: UIImage
    ) {
        authorStackView.configure(image: avatar, name: authorName)
        tripDestinationLabel.text = trip.destination
        tripPeriodLabel.text = trip.period
        aboutTripLabel.text = trip.about
        photoStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for image in trip.images {
            let view = UIImageView()
            view.image = image
            view.contentMode = .scaleAspectFill
            view.clipsToBounds = true
            view.heightAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            photoStackView.addArrangedSubview(view)
        }
        if isFavorite {
            markImageView.tintColor = AppСolor.mainAccent
            markImageView.image = UIImage(systemName: "bookmark.fill")
        } else {
            markImageView.tintColor = AppСolor.forText
            markImageView.image = UIImage(systemName: "bookmark")
        }
        likesLabel.text = String(likesNumber)
        if isLiked {
            likeImageView.tintColor = AppСolor.mainAccent
            likeImageView.image = UIImage(systemName: "hand.thumbsup.fill")
        } else {
            likeImageView.tintColor = AppСolor.forText
            likeImageView.image = UIImage(systemName: "hand.thumbsup")
        }
    }
    
    private func setupUI() {
        backgroundColor = AppСolor.forSecondBackground
        layer.cornerRadius = Spacing.doubleBase.rawValue
        clipsToBounds = true
        
        addSubview(headerStackView)
        addSubview(photoStackView)
        addSubview(aboutTripLabel)
        addSubview(delimiter)
        addSubview(actionsStackView)
        
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        photoStackView.translatesAutoresizingMaskIntoConstraints = false
        aboutTripLabel.translatesAutoresizingMaskIntoConstraints = false
        delimiter.translatesAutoresizingMaskIntoConstraints = false
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
                    constant: Spacing.large.rawValue
                ),
                actionsStackView.trailingAnchor.constraint(
                    equalTo: trailingAnchor,
                    constant: -Spacing.large.rawValue
                ),
                actionsStackView.bottomAnchor.constraint(
                    equalTo: bottomAnchor,
                    constant: -Spacing.base.rawValue
                )
            ]
        )
    }
}
