import UIKit

final class UserHeaderStackView: UIStackView {
    private static let avatarSize: CGFloat = 60
    
    private lazy var authorImage: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = UserHeaderStackView.avatarSize/2
        view.contentMode = .scaleAspectFill
        view.backgroundColor = AppСolor.forBackground
        
        return view
    }()
    
    private lazy var authorNameLabel = TripLabel(style: .boldTitle)
    
    func configure(user: User) {
        authorImage.image = user.avatar
        authorNameLabel.text = user.fullName
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addArrangedSubview(authorImage)
        addArrangedSubview(authorNameLabel)
        self.axis = .horizontal
        self.spacing = Spacing.base.rawValue
        NSLayoutConstraint.activate(
            [
                authorImage.heightAnchor.constraint(equalToConstant: UserHeaderStackView.avatarSize),
                authorImage.widthAnchor.constraint(equalToConstant: UserHeaderStackView.avatarSize)
            ]
        )
    }
}
