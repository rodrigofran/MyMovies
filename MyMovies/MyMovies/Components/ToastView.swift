import UIKit

class ToastView: UIView {
    
    // MARK: - Properties
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    private var hideTimer: Timer?
    
    // MARK: - Initializer
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        addSubview(messageLabel)
        addSubview(closeButton)
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            messageLabel.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: -8),
            
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            closeButton.widthAnchor.constraint(equalToConstant: 20),
            closeButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Methods
    func show(duration: TimeInterval = 5.0, message: String, backgroundColor: UIColor? = .red) {
        self.backgroundColor = backgroundColor
        messageLabel.text = message

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }) {
            keyWindow.addSubview(self)
            
            translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: keyWindow.safeAreaLayoutGuide.topAnchor, constant: 8),
                leadingAnchor.constraint(equalTo: keyWindow.leadingAnchor, constant: 16),
                trailingAnchor.constraint(equalTo: keyWindow.trailingAnchor, constant: -16),
            ])
        }

        alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        }

        hideTimer = Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { [weak self] _ in
            self?.hide()
        }
    }

    func hide() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { _ in
            self.removeFromSuperview()
        }
    }
    
    @objc private func closeButtonTapped() {
        hideTimer?.invalidate()
        hide()
    }
}
