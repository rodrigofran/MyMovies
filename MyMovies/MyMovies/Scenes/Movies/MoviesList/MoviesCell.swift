import UIKit

final class MovieCell: UICollectionViewCell {
    static let identifier = "MovieCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = UIColor.primary
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .center
        stack.spacing = 0
        stack.layer.cornerRadius = 8
        stack.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return stack
        
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private let favoriteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let emptyView = UIView()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(favoriteImageView)
        stackView.addArrangedSubview(emptyView)
        contentView.addSubview(imageView)
        contentView.addSubview(stackView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        favoriteImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300),

            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),
            stackView.heightAnchor.constraint(equalToConstant: 60),
            
            emptyView.widthAnchor.constraint(equalToConstant: 8)
        ])
    }
    
    func configure(with movie: LoadedResult, isFavorited: Bool?) {
        imageView.image = movie.posterImage
        titleLabel.text = movie.title
        
        guard let isFavorited = isFavorited else {
            favoriteImageView.isHidden = true
            return
        }
        
        favoriteImageView.image = UIImage(systemName:  isFavorited ? "heart.fill" : "heart")
        favoriteImageView.tintColor = UIColor.secondary
    }
}

