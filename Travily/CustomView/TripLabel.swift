import UIKit

final class TripLabel: UILabel {
    enum Style {
        case boldTitle
        case mediumText
        case smallLight
    }
    
    let style: Style
    
    init(style: Style, text: String?) {
        self.style = style
        super.init(frame: .zero)
        self.text = text
        setupLabel()
    }
    
    init(style: Style) {
        self.style = style
        super.init(frame: .zero)
        setupLabel()
    }
    
    func setupLabel() {
        textColor = AppСolor.forText
        numberOfLines = 0
        switch style {
        case .boldTitle:
            font = UIFont.systemFont(ofSize: 16, weight: .bold)
        case .mediumText:
            font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        case .smallLight:
            font = UIFont.systemFont(ofSize: 12, weight: .light)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
