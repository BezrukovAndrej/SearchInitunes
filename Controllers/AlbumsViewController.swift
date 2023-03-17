import UIKit

class AlbumsViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .ypBlack
        tableView.register(AlbumsTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let seachController = UISearchController(searchResultsController: nil)
    
    var albums = [Album]()
    var timer: Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupDeligate()
        setNavigationBar()
        setupSearchController()
        setConstraints()
        
    }

    private func setupView() {
        view.addSubview(tableView)
    }
    
    private func setupDeligate() {
        tableView.delegate = self
        tableView.dataSource = self
        
        seachController.searchBar.delegate = self
    }
    
    private func setNavigationBar() {
        navigationItem.title = "Album"
        navigationController?.navigationBar.tintColor = .ypWhite
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.ypWhite]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true

        navigationItem.searchController = seachController
        
        let userInfoButton = createCustomButton(selector: #selector(userInfoButtonTapped))
        navigationItem.rightBarButtonItem = userInfoButton
    }
    
    private func setupSearchController() {
        seachController.searchBar.placeholder = "Search"
        seachController.searchBar.searchTextField.textColor = .ypWhite
        seachController.searchBar.tintColor = .ypWhite
        seachController.obscuresBackgroundDuringPresentation = false
    }
    
    @objc private func userInfoButtonTapped() {
        let userInfoViewController = UserInfoViewController()
        navigationController?.pushViewController(userInfoViewController, animated: true)
    }
    
    private func feachAlbum(albumName: String) {
        
        let urlString = "https://itunes.apple.com/search?term=\(albumName)&entity=album&attribete=albumTerm"
        
        NetworkDataFetch.shared.fetchAlbum(urlSting: urlString) {[weak self] albumModel, error in
            
            if error == nil {
                guard let albumModel = albumModel else { return }
                
                if albumModel.results != [] {
                    let sortedAlbums = albumModel.results.sorted { firstItem, secondItem in
                        return firstItem.collectionName.compare(secondItem.collectionName) == ComparisonResult.orderedAscending
                    }
                    self?.albums = sortedAlbums
                    print(self?.albums)
                    self?.tableView.reloadData()
                } else {
                    self?.alertOk(title: "Error", message: "Album not founded. Add some words")
                }
            } else {
                print(error!.localizedDescription)
            }
        }
    }
}
// MARK: - UITableViewDataSource
extension AlbumsViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albums.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AlbumsTableViewCell
        let album = albums[indexPath.row]
        cell.configaAlbumCell(album: album)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension AlbumsViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailAlbumViewController = DetailAlbumViewController()
        let album = albums[indexPath.row]
        detailAlbumViewController.album = album
        detailAlbumViewController.title = album.artistName
        navigationController?.pushViewController(detailAlbumViewController, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension AlbumsViewController: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let text = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        if searchText != "" {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
                self?.feachAlbum(albumName: text!)
            })
        }
    }
}

// MARK: - Set Constraints
extension AlbumsViewController {
    
    func setConstraints() {
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
