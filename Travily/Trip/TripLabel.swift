import UIKit

///Текстовый вью с кастомными шрифтами
final class TripLabel: UILabel {
    let style: FontStyle
    
    init(style: FontStyle, text: String?) {
        self.style = style
        super.init(frame: .zero)
        self.text = text
        setupLabel()
    }
    
    init(style: FontStyle) {
        self.style = style
        super.init(frame: .zero)
        setupLabel()
    }
    
    func setupLabel() {
        textColor = AppСolor.forText
        numberOfLines = 0
        switch style {
        case .boldTitle:
            font = FontStyle.boldStyle
        case .mediumText:
            font = FontStyle.mediumStyle
        case .smallLightText:
            font = FontStyle.smallStyle
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
