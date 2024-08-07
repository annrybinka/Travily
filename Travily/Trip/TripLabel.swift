import UIKit

///Текстовый вью с кастомными шрифтами
final class TripLabel: UILabel {
    private let style: FontStyle.TextType
    
    init(style: FontStyle.TextType, text: String?) {
        self.style = style
        super.init(frame: .zero)
        self.text = text
        setupLabel()
    }
    
    init(style: FontStyle.TextType) {
        self.style = style
        super.init(frame: .zero)
        setupLabel()
    }
    
    private func setupLabel() {
        
        numberOfLines = 0
        switch style {
        case .boldTitle:
            font = FontStyle.boldTitleFont
            textColor = AppСolor.forText
        case .mediumText:
            font = FontStyle.mediumTextFont
            textColor = AppСolor.forText
        case .smallLightText:
            font = FontStyle.smallLightTextFont
            textColor = AppСolor.forText
        case .accentText:
            font = FontStyle.accentTextFont
            textColor = AppСolor.mainAccent
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
