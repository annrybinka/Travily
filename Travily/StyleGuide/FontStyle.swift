import UIKit

enum FontStyle {
    static let boldStyle = UIFont.createFont(size: 16, weight: .bold)
    static let mediumStyle = UIFont.createFont(size: 14, weight: .semibold)
    static let smallStyle = UIFont.createFont(size: 12, weight: .light)
    
    case boldTitle
    case mediumText
    case smallLightText
}

extension UIFont {
    static func createFont(size: CGFloat, weight: UIFont.Weight) -> UIFont {
        UIFont.systemFont(ofSize: size, weight: weight)
    }
}
