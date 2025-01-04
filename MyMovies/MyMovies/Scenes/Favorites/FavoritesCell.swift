import UIKit

final class FavoriteMovieCell: UITableViewCell {
    
    static let identifier = "FavoriteMovieCell"
    
    private let backdropImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.textAlignment = .right
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 3
        return label
    }()
    
    private let titleDateStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private let mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(backdropImageView)
        contentView.addSubview(mainStackView)
        
        titleDateStackView.addArrangedSubview(titleLabel)
        titleDateStackView.addArrangedSubview(releaseDateLabel)
        mainStackView.addArrangedSubview(titleDateStackView)
        mainStackView.addArrangedSubview(overviewLabel)
        
        backdropImageView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backdropImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            backdropImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            backdropImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),
            backdropImageView.widthAnchor.constraint(equalToConstant: 100),
            backdropImageView.heightAnchor.constraint(equalToConstant: 100),
            
            mainStackView.leadingAnchor.constraint(equalTo: backdropImageView.trailingAnchor, constant: 12),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with movie: FavoriteMovieModel) {
        backdropImageView.image = UIImage(data: movie.imageData)
        titleLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate
        overviewLabel.text = movie.overview
    }
}
