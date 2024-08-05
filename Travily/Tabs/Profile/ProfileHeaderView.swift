import UIKit

final class ProfileHeaderView: UIView {
    
    
    func configure(user: User) {
//        fullNameLabel.text = user.fullName
//        statusLabel.text = user.status
//        avatarImageView.image = user.avatar
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
    }
}
