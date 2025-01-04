import UIKit

protocol FavoritesDisplayLogic: AnyObject {
    func displayFavoritesMovies(favoritesMovies: [FavoriteMovieModel])
    func displayRemovedFavoriteMovie(at indexPath: IndexPath, _ errorMessage: String)
    func displayErrorDatabase(_ errorMessage: String)
}

final class FavoritesMoviesViewController: UIViewController {
    
    private let interactor: FavoritesBusinessLogic
    private let router: FavoritesRoutingLogic
    private var favoritesMovies: [FavoriteMovieModel] = []
    
    private let toastView: ToastView
    private let errorView: ErrorView
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FavoriteMovieCell.self, forCellReuseIdentifier: FavoriteMovieCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        return tableView
    }()
    
    init(interactor: FavoritesBusinessLogic,
         router: FavoritesRoutingLogic,
         toastView: ToastView = ToastView(),
         errorView: ErrorView = ErrorView()
    ) {
        self.interactor = interactor
        self.router = router
        
        self.toastView = toastView
        self.errorView = errorView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar (
            title: "Movies List"
        )
        
        setupUI()
        setupErrorView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        errorView.isHidden = true
        interactor.viewWillAppear()
        
    }
    
    private func setupUI() {
        title = "Favorite Movies"
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setupErrorView() {
        view.addSubview(errorView)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: view.topAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        errorView.configure(
            image: UIImage(systemName: "exclamationmark.triangle"),
            text: "Something went wrong. Please try again.",
            onRetry: { [weak self] in
                self?.retryFetchingData()
            }
        )
    }
    
    private func retryFetchingData() {
        showErrorView(false)
        interactor.viewWillAppear()
    }
    
    private func showEmptyState() {
        errorView.configure(image: UIImage(systemName: "heart.slash.fill"),
                            text: "Oops! You don't have any movies in your favorites yet.",
                            hideRetryButton: true) {}
        showErrorView(true)
    }
    
    private func showErrorView(_ show: Bool) {
        self.errorView.isHidden = !show
        self.tableView.isHidden = show
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension FavoritesMoviesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteMovieCell.identifier, for: indexPath) as? FavoriteMovieCell else {
            return UITableViewCell()
        }
        
        guard indexPath.row >= 0 && indexPath.row < favoritesMovies.count else {
            return UITableViewCell()
        }
        
        let movie = favoritesMovies[indexPath.row]
        cell.configure(with: movie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard indexPath.row < favoritesMovies.count else { return }
            let movie = favoritesMovies[indexPath.row]
            
            interactor.removeFavoriteMovie(id: movie.id, indexPath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favoriteMovie = favoritesMovies[indexPath.row]
        
        let dto = LoadedResult(genreIds: favoriteMovie.genresIds,
                               id: favoriteMovie.id,
                               title: favoriteMovie.title,
                               overview: favoriteMovie.overview,
                               backdropPath: nil,
                               posterPath: nil,
                               releaseDate: favoriteMovie.releaseDate,
                               posterImage: nil,
                               backdropImage: UIImage(data: favoriteMovie.imageData),
                               isFavorited: true)
        
        router.navigateToMovieDetail(movie: dto)
    }

}

extension FavoritesMoviesViewController: FavoritesDisplayLogic {
    func displayFavoritesMovies(favoritesMovies: [FavoriteMovieModel]) {
        self.favoritesMovies = favoritesMovies
        
        if favoritesMovies.isEmpty {
            showEmptyState()
        } else {
            self.showErrorView(false)
            self.tableView.reloadData()
        }
    }
    
    func displayRemovedFavoriteMovie(at indexPath: IndexPath, _ errorMessage: String) {
        favoritesMovies.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        
        if favoritesMovies.isEmpty {
            showEmptyState()
        }
        
        self.toastView.show(
            message: errorMessage,
            backgroundColor: UIColor.toastPositive
        )
    }
    
    func displayErrorDatabase(_ errorMessage: String) {
        self.toastView.show(
            message: errorMessage,
            backgroundColor: .red
        )
    }
    
    func didFailWithError(_ error: any Error) {
        self.showErrorView(true)
    }
    
}
