import UIKit

// MARK: - Protocol ViewController
protocol MoviesListDisplayLogic: AnyObject {
    func displayMovies(movies: [LoadedResult])
    func displayMoviesWithError()
    func displayNextMovies(movies: [LoadedResult])
    func displayNextMoviesWithError()
    func updateFavoriteMovieStatus(movieID: Int)
}

final class MoviesListViewController: UIViewController {
    
    // MARK: - Properties
    private let interactor: MoviesListBusinessLogic
    private let router: MoviesListRoutingLogic
    private var movies: [LoadedResult] = []
    
    // MARK: - UI Components
    private let errorView = ErrorView()
    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .gray
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private let footerSpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private let toastView = ToastView()
    
    // MARK: - Init
    init(interactor: MoviesListBusinessLogic, router: MoviesListRoutingLogic) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar(title: "Movies List")
        
        setupSearchBar()
        setupUI()
        setupErrorView()
        errorView.isHidden = true
        collectionView.dataSource = self
        collectionView.delegate = self
        
        activityIndicator.startAnimating()
        interactor.viewDidLoad(isFirstFetch: true)
    }
    
    // MARK: - UI Setup
    private func setupSearchBar() {
        let textField = searchController.searchBar.searchTextField
        textField.attributedPlaceholder = NSAttributedString(
            string: "Search movies...",
            attributes: [.foregroundColor: UIColor.white]
        )
        
        if let glassIconView = textField.leftView as? UIImageView {
            glassIconView.tintColor = .white
        }
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupUI() {
        view.removeFromSuperview()
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        view.addSubview(footerSpinner)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        footerSpinner.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            footerSpinner.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            footerSpinner.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: footerSpinner.bottomAnchor, constant: -8),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
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
    
    // MARK: - Error Handling
    private func showEmptyState() {
        errorView.configure(
            image: UIImage(systemName: "exclamationmark.magnifyingglass"),
            text: "Oops! Unable to find movie.",
            hideRetryButton: true
        ) {}
        showErrorView(true)
    }
    
    private func showErrorView(_ show: Bool) {
        DispatchQueue.main.async  { [weak self] in
            guard let self = self else { return }
            self.errorView.isHidden = !show
            self.collectionView.isHidden = show
        }
    }
    
    private func retryFetchingData() {
        showErrorView(false)
        activityIndicator.startAnimating()
        interactor.viewDidLoad(isFirstFetch: true)
    }
    
    // MARK: - Data Handling
    private func getMovies() -> [LoadedResult] {
        guard let query = searchController.searchBar.text, !query.isEmpty else {
            return movies
        }
        return movies.filter {
            $0.title?.lowercased().contains(query.lowercased()) ?? false
        }
    }
}

extension MoviesListViewController: UICollectionViewDataSource {
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getMovies().count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else {
            return UICollectionViewCell()
        }
        let movie = getMovies()[indexPath.item]
        
        cell.configure(with: movie, isFavorited: movie.isFavorited)
        return cell
    }
}

extension MoviesListViewController: UICollectionViewDelegate {
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = getMovies()[indexPath.item]
        router.navigateToMovieDetail(movie: selectedMovie)
    }
}

extension MoviesListViewController: UICollectionViewDelegateFlowLayout {
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width/2 - 20
        return CGSize(width: width, height: 380)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}

extension MoviesListViewController {
    // MARK: - Scroll Handling
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !self.activityIndicator.isAnimating {
            let position = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            let frameHeight = scrollView.frame.size.height
            
            if position > (contentHeight - frameHeight - 100) {
                footerSpinner.startAnimating()
                interactor.viewDidLoad(isFirstFetch: false)
            }
        }
    }
}

extension MoviesListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    // MARK: - UISearchResultsUpdating, UISearchBarDelegate
    func updateSearchResults(for searchController: UISearchController) {
        let movies = getMovies()
        
        if movies.isEmpty {
            showEmptyState()
        } else {
            showErrorView(false)
        }
        collectionView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.searchTextField.attributedPlaceholder = nil
        searchBar.searchTextField.textColor = .white
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search movies...",
            attributes: [.foregroundColor: UIColor.white]
        )
    }
}

extension MoviesListViewController: MoviesListDisplayLogic {
    // MARK: - MoviesListDisplayLogic
    func displayMovies(movies: [LoadedResult]) {
        self.movies.removeAll()
        self.movies.append(contentsOf: movies)
        self.activityIndicator.stopAnimating()
        self.footerSpinner.stopAnimating()
        self.collectionView.reloadData()
    }
    
    func displayMoviesWithError() {
        self.activityIndicator.stopAnimating()
        self.footerSpinner.stopAnimating()
        self.showErrorView(true)
    }
    
    func displayNextMovies(movies: [LoadedResult]) {
        self.movies.append(contentsOf: movies)
        self.activityIndicator.stopAnimating()
        self.footerSpinner.stopAnimating()
        self.collectionView.reloadData()
    }
    
    func displayNextMoviesWithError() {
        self.activityIndicator.stopAnimating()
        self.footerSpinner.stopAnimating()
        self.toastView.show(message: "Failed to load next movies. Please try again.")
    }
    
    func updateFavoriteMovieStatus(movieID: Int) {
        guard let index = getMovies().firstIndex(where: { $0.id == movieID }) else {
            return
        }
        
        getMovies()[index].changeFavoriteStatus()
        
        if let cell = collectionView.cellForItem(at: IndexPath(row: index, section: 0)) as? MovieCell {
            let movie = getMovies()[index]
            
            cell.configure(with: movie, isFavorited: movie.isFavorited)
        }
    }
}
