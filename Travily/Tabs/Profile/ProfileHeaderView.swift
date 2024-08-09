import UIKit

final class ProfileHeaderView: UIView {
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
    
    private lazy var tripButton = ProfileButton(title: "Рассказать о поездке") {
        print("button tapped")
    }
    
    private lazy var messageButton = ProfileButton(title: "Написать сообщение") {
        print("button tapped")
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
    
    func configure(isCurrent: Bool, login: String, avatar: UIImage, name: String, aboutMe: String, tripsNumber: Int, subscriptions: Int, followers: Int) {
        loginLabel.text = login
        userStackView.configure(image: avatar, name: name)
        aboutMeLabel.text = aboutMe
        tripsLabel.text = String.createLabel(
            type: .trips,
            with: tripsNumber
        )
        subscriptionsLabel.text = String.createLabel(
            type: .subscriptions,
            with: subscriptions
        )
        followersLabel.text = String.createLabel(
            type: .followers,
            with: followers
        )
        if isCurrent {
            stackView.addArrangedSubview(tripButton)
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
