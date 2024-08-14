import UIKit

protocol ProfileHeaderViewDelegate: AnyObject {
    func onCreateTripButtonTap()
    func onMessageButtonTap()
}

final class ProfileHeaderView: UIView {
    weak var delegate: ProfileHeaderViewDelegate?
    
    private lazy var loginLabel = TripLabel(style: .accentText)
    private lazy var userStackView = UserHeaderStackView()
    private lazy var aboutMeLabel = TripLabel(style: .smallLightText)
    private lazy var delimiter: UIView = {
        let view = UIView()
        view.backgroundColor = AppСolor.lightGray
        view.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        return view
    }()
    private lazy var tripsLabel = TripLabel(style: .mediumText)
    private lazy var subscriptionsLabel = TripLabel(style: .mediumText)
    private lazy var followersLabel = TripLabel(style: .mediumText)
    private lazy var infoStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .equalCentering
        [tripsLabel, subscriptionsLabel, followersLabel].forEach {
            view.addArrangedSubview($0)
            $0.textAlignment = .center
        }
        return view
    }()
    
    private lazy var createTripButton = ProfileButton(title: "Рассказать о поездке") {
        self.delegate?.onCreateTripButtonTap()
    }
    
    private lazy var messageButton = ProfileButton(title: "Написать сообщение") {
        self.delegate?.onMessageButtonTap()
    }
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = Spacing.base.rawValue
        view.addArrangedSubview(loginLabel)
        view.addArrangedSubview(userStackView)
        view.addArrangedSubview(delimiter)
        view.addArrangedSubview(infoStackView)
        view.addArrangedSubview(aboutMeLabel)
        
        return view
    }()
    
    func configure(isCurrentUser: Bool, userData: UserProfileData) {
        loginLabel.text = userData.login
        userStackView.configure(image: userData.avatar, name: userData.fullName)
        aboutMeLabel.text = userData.aboutMe
        tripsLabel.text = String.createLabel(
            type: .trips,
            with: userData.tripsNumber
        )
        subscriptionsLabel.text = String.createLabel(
            type: .subscriptions,
            with: userData.subscriptionsNumber
        )
        followersLabel.text = String.createLabel(
            type: .followers,
            with: userData.followersNumber
        )
        if isCurrentUser {
            stackView.addArrangedSubview(createTripButton)
        } else {
            stackView.addArrangedSubview(messageButton)
        }
        stackView.addArrangedSubview(UIView())
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                stackView.topAnchor.constraint(equalTo: topAnchor),
                stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
                stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.doubleBase.rawValue),
                stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.doubleBase.rawValue)
            ]
        )
    }
}
