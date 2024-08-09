import UIKit

final class UserHeaderStackView: UIStackView {
    private static let avatarSize: CGFloat = 60
    
    private lazy var authorImage: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = UserHeaderStackView.avatarSize/2
        view.heightAnchor.constraint(equalToConstant: UserHeaderStackView.avatarSize).isActive = true
        view.widthAnchor.constraint(equalToConstant: UserHeaderStackView.avatarSize).isActive = true
        
        return view
    }()
    
    private lazy var authorNameLabel = TripLabel(style: .boldTitle)
    
    func configure(image: UIImage, name: String) {
        authorImage.image = image
        authorNameLabel.text = name
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
    }
}
