import UIKit

// MARK: - Protocol ViewController
protocol MovieDetailDisplayLogic: AnyObject {
    func getMovieGenreIds() -> [Int]?
    func displayGenres(labelText: String?, hide: Bool)
    func displayErrorFetchingGenres()
    func displaySavedFavoriteMovie(_ isFavorited: Bool)
    func displayRemovedFavoriteMovie(_ isFavorited: Bool)
    func displayErrorDatabase()
}

final class MovieDetailViewController: UIViewController {
    
    // MARK: - Properties
    private let interactor: MovielDetailBusinessLogic
    private let movie: LoadedResult
    
    // MARK: - UI Components
    private let toastView = ToastView()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .gray
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        button.tintColor = UIColor.secondary
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    
    private let genresLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let firstDivider = UIView.makeDivider()
    private let secondDivider = UIView.makeDivider()
    private let genresDivider = UIView.makeDivider()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            headerStackView,
            firstDivider,
            releaseDateLabel,
            secondDivider,
            genresLabel,
            genresDivider,
            overviewLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, favoriteButton])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 0
        return stackView
    }()
    
    private let bottomFavoriteButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.configuration?.baseBackgroundColor = UIColor.primary
        button.configuration?.cornerStyle = .medium
        return button
    }()
    
    // MARK: - Init
    init(interactor: MovielDetailBusinessLogic, movie: LoadedResult) {
        self.movie = movie
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(title: "Movie Detail", showCloseButton: true)
        setupUI()
        setupBindings()
        interactor.viewDidLoad()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(mainImageView)
        view.addSubview(mainStackView)
        view.addSubview(bottomFavoriteButton) // Adicione o botão à view
        
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomFavoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainImageView.heightAnchor.constraint(equalToConstant: 300),
            
            mainStackView.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 16),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomFavoriteButton.topAnchor, constant: -16),
            
            bottomFavoriteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bottomFavoriteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            bottomFavoriteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            bottomFavoriteButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        mainImageView.image = movie.backdropImage
        titleLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate
        overviewLabel.text = movie.overview
        favoriteButton.isSelected = movie.isFavorited
        updateBottomFavoriteButton(movie.isFavorited)
    }
    
    // MARK: - Actions
    private func setupBindings() {
        favoriteButton.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)
        bottomFavoriteButton.addTarget(self, action: #selector(bottomButtonTapped), for: .touchUpInside)
    }
    
    @objc private func toggleFavorite() {
        guard let id = movie.id else { return }
        try? interactor.addOrRemoveFavorites(movie: movie, id: id)
    }
    
    @objc private func bottomButtonTapped() {
        toggleFavorite()
    }
    
    // MARK: - Helper Methods
    private func updateBottomFavoriteButton(_ isFavorited: Bool) {
        var config = bottomFavoriteButton.configuration
        if isFavorited {
            config?.title = "Remove from Favorites"
            config?.image = UIImage(systemName: "heart.slash")
        } else {
            config?.title = "Add to Favorites"
            config?.image = UIImage(systemName: "heart")
        }
        config?.imagePadding = 8
        config?.baseForegroundColor = .white
        bottomFavoriteButton.configuration = config
    }
    
}

// MARK: - Display Logic Methods

extension MovieDetailViewController: MovieDetailDisplayLogic {
    
    func getMovieGenreIds() -> [Int]? {
        return movie.genreIds
    }
    
    func displayGenres(labelText: String?, hide: Bool) {
        if hide || (labelText ?? "").isEmpty {
            genresLabel.isHidden = true
            genresDivider.isHidden = true
        } else {
            genresLabel.text = labelText
            genresLabel.isHidden = false
            genresDivider.isHidden = false
        }
        activityIndicator.stopAnimating()
    }
    
    func displayErrorFetchingGenres() {
        activityIndicator.stopAnimating()
        genresLabel.isHidden = true
        genresDivider.isHidden = true
        toastView.show(message: "Error fetching genres")
    }
    
    func displaySavedFavoriteMovie(_ isFavorited: Bool) {
        updateBottomFavoriteButton(isFavorited)
        favoriteButton.isSelected = isFavorited
        toastView.show(message: "Movie added to favorites", backgroundColor: UIColor.toastPositive)
    }
    
    func displayRemovedFavoriteMovie(_ isFavorited: Bool) {
        updateBottomFavoriteButton(isFavorited)
        favoriteButton.isSelected = isFavorited
        toastView.show(message: "Movie removed from favorites", backgroundColor: UIColor.toastPositive)
    }
    
    func displayErrorDatabase() {
        toastView.show(message: "An error occurred while accessing the database")
    }
}
