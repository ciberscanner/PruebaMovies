//
//  MoviesViewController.swift
//  PruebaiOS
//
//  Created by Diego Fernando Serna Salazar on 21.10.21.
//

import UIKit
import ViewAnimator

protocol MoviesViewProtocol {
    var presenter: MoviesPresenterProtocol? {get set}
    func showMovies(with moviesRequest: MoviesRequest)
    func showMovies(with movies: [Movie])
}

class MoviesViewController: UIViewController {
    //--------------------------------------------------------------------
    //Variables
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "movieTableViewCell")
        return table
    }()
    
    var presenter: MoviesPresenterProtocol?
    var configurator: MoviesConfigurator = MoviesConfigurator()
    var path: Path?
    var page = 1
    var maxPage = 1
    var movies: [Movie] = []
    var filterMovies: [Movie] = []
    var isPaginating = false
    var query = ""
    var isNewQuery = false
    //--------------------------------------------------------------------
    //Constructor
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        if Reachability.isConnectedToNetwork(){
            if path == Path.search{
                setSearchBar()
            }else{
                presenter?.getMovies(category: path!, parameters: parametersMovies())
            }
        }else{
            presenter?.getMovies(category: path!, parameters: parametersMovies())
            setSearchBar()
        }
    }
    //--------------------------------------------------------------------
    //
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let animation = AnimationType.from(direction: .top, offset: 300)
        UIView.animate(views: tableView.visibleCells, animations: [animation])
        
    }
    //--------------------------------------------------------------------
    //
    private func setSearchBar(){
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true // Navigation bar large titles
            navigationItem.title = title
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
            
            let searchController = UISearchController(searchResultsController: nil) // Search Controller
            searchController.searchResultsUpdater = self
            searchController.obscuresBackgroundDuringPresentation = false
            navigationItem.hidesSearchBarWhenScrolling = true
            navigationItem.searchController = searchController
            
            searchController.searchBar.delegate = self
        }
    }
    //--------------------------------------------------------------------
    //
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
}

extension MoviesViewController: MoviesViewProtocol{
    //--------------------------------------------------------------------
    //
    func showMovies(with moviesRequest: MoviesRequest) {
        maxPage = moviesRequest.totalPages
        if maxPage > page{
            isPaginating = true
        }
        if isNewQuery{
            self.movies = moviesRequest.results
            isNewQuery = false
        }
        movies.append(contentsOf: moviesRequest.results)
        self.tableView.tableFooterView = nil
        tableView.reloadData()
    }
    
    func showMovies(with movies: [Movie]) {
        self.movies = movies
        tableView.reloadData()
    }
}

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate{
    //--------------------------------------------------------------------
    //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    //--------------------------------------------------------------------
    //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieTableViewCell")as! MovieTableViewCell
        cell.setCell(item: movies[indexPath.row])
        return cell
    }
    //--------------------------------------------------------------------
    //
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.showDetail(movie: movies[indexPath.row])
    }
    //--------------------------------------------------------------------
    //
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    //--------------------------------------------------------------------
    //
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    //--------------------------------------------------------------------
    //
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > tableView.contentSize.height-100-scrollView.frame.size.height {
            if !isPaginating{
                return
            }else{
                self.tableView.tableFooterView = createSpinnerFooter()
                isPaginating = false
                page+=1
                if path == Path.search {
                    if !query.isEmpty{
                        self.presenter?.getMovies(category: path!, parameters: parametersFilter(page: page, query: query))
                    }else{
                        self.tableView.tableFooterView = nil
                    }
                }else{
                    self.presenter?.getMovies(category: path!, parameters: parametersMovies(page: page))
                }
                
            }
        }
    }
}

extension MoviesViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        page = 1
        query = searchText
        if path == Path.search{
            if query.isEmpty{
                movies = []
                tableView.reloadData()
            }else{
                isNewQuery = true
                self.presenter?.getMovies(category: path!, parameters: parametersFilter(page: page, query: searchText))
            }
        }else{
            if query.isEmpty{
                presenter?.getMovies(category: path!, parameters: parametersMovies())
            }else{
                presenter?.getFilterMovies(category: path!, name: searchText)
            }
        }
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if query.isEmpty{
            
            if path != Path.search{
                presenter?.getMovies(category: path!, parameters: parametersMovies())
            }else{
                movies = []
                tableView.reloadData()
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        query = ""
    }
}
