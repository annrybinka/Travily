import UIKit

///Стэк с несколькими сабвью
final class TripStackView: UIStackView {
//    view.contentMode = .scaleAspectFill ?
    
    init(subviews: [UIView], axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution) {
        super.init(frame: .zero)
        subviews.forEach { addArrangedSubview($0) }
        self.axis = axis
        self.distribution = distribution
    }
    
    init(subviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: Spacing) {
        super.init(frame: .zero)
        subviews.forEach { addArrangedSubview($0) }
        self.axis = axis
        self.spacing = spacing.rawValue
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
