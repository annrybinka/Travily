import UIKit

final class ProfileButton: UIButton {
    private let title: String
    private let tapAction: (() -> Void)
    
    init(title: String, tapAction: @escaping () -> Void) {
        self.title = title
        self.tapAction = tapAction
        super.init(frame: .zero)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        self.setTitle(title, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.setTitleColor(AppСolor.mainAccent, for: .highlighted)
        self.setTitleShadowColor(.black, for: .focused)
        
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.backgroundColor = AppСolor.mainAccent
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        self.tapAction()
    }
}
