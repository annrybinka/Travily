import UIKit

final class TripTableViewCell: UITableViewCell {
    static let id = "TripTableViewCell"
    private lazy var viewForCell = TripCellView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(
        with trip: Trip,
        isFavorite: Bool,
        isLiked: Bool,
        likesNumber: Int,
        authorName: String,
        avatar: UIImage
    ) {
        viewForCell.configure(
            trip: trip,
            isFavorite: isFavorite,
            isLiked: isLiked,
            likesNumber: likesNumber,
            authorName: authorName,
            avatar: avatar
        )
    }
    
    func set(delegate: TripCellViewDelegate, tag: Int) {
        viewForCell.delegate = delegate
        viewForCell.tag = tag
    }
    
    private func setupUI() {
        contentView.backgroundColor = AppСolor.forBackground
        contentView.addSubview(viewForCell)
        viewForCell.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate(
            [
                viewForCell.topAnchor.constraint(
                    equalTo: contentView.topAnchor,
                    constant: Spacing.base.rawValue
                ),
                viewForCell.bottomAnchor.constraint(
                    equalTo: contentView.bottomAnchor,
                    constant: -Spacing.base.rawValue
                ),
                viewForCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                viewForCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ]
        )
    }
}
