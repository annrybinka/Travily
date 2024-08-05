import UIKit

enum AppСolor {
   static let forBackground = UIColor.createColor(
        lightMode: .white,
        darkMode: .black
    )
    static let forSecondBackground = UIColor.createColor(
         lightMode: .systemGray6,
         darkMode: .systemGray6
     )
    static let forText = UIColor.createColor(
        lightMode: .black,
        darkMode: .white
    )
    static let forSecondText = UIColor.createColor(
        lightMode: .darkGray,
        darkMode: .lightGray
    )
    static let lightGray = UIColor.createColor(
        lightMode: .lightGray,
        darkMode: .lightGray
    )
}

extension UIColor {
    static func createColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else {
            return lightMode
        }
        return UIColor { (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? lightMode :
            darkMode
        }
    }
}
