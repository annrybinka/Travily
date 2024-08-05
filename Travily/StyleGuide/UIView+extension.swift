import UIKit

//Исправить или удалить
extension UIView {
    struct ConstraintX {
        let equalTo: NSLayoutAnchor<NSLayoutXAxisAnchor>
        let constant: Spacing?
    }
    
    struct ConstraintY {
        let equalTo: NSLayoutAnchor<NSLayoutYAxisAnchor>
        let constant: Spacing?
    }
    
    func setConstraints(
        top: ConstraintY?,
        leading: ConstraintX?,
        trailing: ConstraintX?,
        bottom: ConstraintY?
    ) {
        if top != nil {
            guard let constent = top!.constant else {
                self.topAnchor.constraint(equalTo: top!.equalTo).isActive = true
                return
            }
            self.topAnchor.constraint(equalTo: top!.equalTo, constant: constent.rawValue).isActive = true
        }
        if leading != nil {
            guard let constent = leading!.constant else {
                self.leadingAnchor.constraint(equalTo: leading!.equalTo).isActive = true
                return
            }
            self.leadingAnchor.constraint(equalTo: leading!.equalTo, constant: constent.rawValue).isActive = true
        }
        if trailing != nil {
            guard let constent = trailing!.constant else {
                self.trailingAnchor.constraint(equalTo: trailing!.equalTo).isActive = true
                return
            }
            self.trailingAnchor.constraint(equalTo: trailing!.equalTo, constant: constent.rawValue).isActive = true
        }
        if bottom != nil {
            guard let constent = bottom!.constant else {
                self.bottomAnchor.constraint(equalTo: bottom!.equalTo).isActive = true
                return
            }
            self.bottomAnchor.constraint(equalTo: bottom!.equalTo, constant: constent.rawValue).isActive = true
        }
    }
}
