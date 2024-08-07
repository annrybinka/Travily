import UIKit

enum FontStyle {
    enum TextType {
        case boldTitle
        case mediumText
        case smallLightText
        case accentText
    }
    
    static let boldTitleFont = UIFont.createFont(size: 16, weight: .bold)
    static let mediumTextFont = UIFont.createFont(size: 14, weight: .semibold)
    static let smallLightTextFont = UIFont.createFont(size: 12, weight: .light)
    static let accentTextFont = UIFont.createFont(size: 14, weight: .semibold)
}

extension UIFont {
    static func createFont(size: CGFloat, weight: UIFont.Weight) -> UIFont {
        UIFont.systemFont(ofSize: size, weight: weight)
    }
}
