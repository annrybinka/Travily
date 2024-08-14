import UIKit

///Поле для ввода текста с кастомными шрифтами
final class TripTextField: UITextField {
    init(style: FontStyle.TextType, placeholder: String?, delegate: UITextFieldDelegate?) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        self.delegate = delegate
        
        backgroundColor = AppСolor.forSecondBackground
        tintColor = AppСolor.mainAccent
        borderStyle = UITextField.BorderStyle.roundedRect
        returnKeyType = UIReturnKeyType.next
        
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
