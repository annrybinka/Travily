import UIKit

final class CreateTripViewController: UIViewController {
    private let viewModel: ProfileViewModel
    private var images: [UIImage] = []
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        
        return scrollView
    }()
    
    private lazy var destinationText = TripTextField(
        style: .mediumText,
        placeholder: "*где вы побывали или куда собираетесь",
        delegate: self
    )
    private lazy var periodText = TripTextField(
        style: .mediumText,
        placeholder: "*укажите период поездки",
        delegate: self
    )
    private lazy var aboutText = TripTextField(
        style: .mediumText,
        placeholder: "добавьте описание (по желанию)",
        delegate: self
    )
    
    private lazy var imageLabel = TripLabel(style: .mediumText, text: "Вы добавили: 0 фото")
    
    private lazy var addImageButton = ProfileButton(title: "Добавить фото") {
        self.viewModel.showImagePicker(delegate: self)
    }
    
    private lazy var publishButton = ProfileButton(title: "Опубликовать") {
        guard self.destinationText.text != "" else {
            self.destinationText.borderStyle = .bezel
            return
        }
        guard self.periodText.text != "" else {
            self.periodText.borderStyle = .bezel
            return
        }
        let trip = TripData(
            destination: self.destinationText.text!,
            period: self.periodText.text!,
            about: self.aboutText.text,
            images: self.images
        )
        self.viewModel.createNew(trip: trip)
        self.dismiss(animated: true)
    }
    
    private lazy var imageStack: UIStackView = {
        let view = UIStackView()
        view.addArrangedSubview(imageLabel)
        view.addArrangedSubview(addImageButton)
        view.axis = .horizontal
        view.spacing = Spacing.base.rawValue
        
        return view
    }()
    
    private lazy var tripStack: UIStackView = {
        let view = UIStackView()
        view.addArrangedSubview(imageStack)
        view.addArrangedSubview(destinationText)
        view.addArrangedSubview(periodText)
        view.addArrangedSubview(aboutText)
        view.addArrangedSubview(publishButton)
        view.axis = .vertical
        view.spacing = Spacing.base.rawValue
        view.setCustomSpacing(Spacing.doubleBase.rawValue, after: imageStack)
        view.setCustomSpacing(Spacing.doubleBase.rawValue, after: aboutText)
        
        return view
    }()
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboardObservers()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppСolor.forBackground
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
    }
    
    private func setupUI() {
        let contentView = UIView()
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(tripStack)
        
        [contentView, scrollView, tripStack].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        [destinationText, periodText, aboutText].forEach { view in
            view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        }
        NSLayoutConstraint.activate(
            [
                scrollView.topAnchor.constraint(equalTo: view.topAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                
                contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                
                tripStack.topAnchor.constraint(
                    equalTo: contentView.topAnchor,
                    constant: Spacing.large.rawValue
                ),
                tripStack.leadingAnchor.constraint(
                    equalTo: contentView.leadingAnchor,
                    constant: Spacing.large.rawValue
                ),
                tripStack.trailingAnchor.constraint(
                    equalTo: contentView.trailingAnchor,
                    constant: -Spacing.large.rawValue
                ),
                tripStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ]
        )
    }
    
    private func setupKeyboardObservers() {
            let notificationCenter = NotificationCenter.default

            notificationCenter.addObserver(
                self,
                selector: #selector(self.willShowKeyoard(_:)),
                name: UIResponder.keyboardWillShowNotification,
                object: nil)
            
            notificationCenter.addObserver(
                self,
                selector: #selector(self.willHideKeyoard(_:)),
                name: UIResponder.keyboardWillHideNotification,
                object: nil)
        }
        
        private func removeKeyboardObservers() {
            let notificationCenter = NotificationCenter.default
            notificationCenter.removeObserver(self)
        }
        
        @objc private func willShowKeyoard(_ notification: NSNotification) {
            let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
            scrollView.contentInset.bottom += keyboardHeight ?? 0.0
        }
        
        @objc private func willHideKeyoard(_ notification: NSNotification) {
            scrollView.contentInset.bottom = 0.0
        }
}

extension CreateTripViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension CreateTripViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        if let image = info[.originalImage] as? UIImage {
            images.append(image)
            imageLabel.text = "Вы добавили: \(images.count) фото"
        }
        picker.dismiss(animated: true)
    }
}
