//
//  HomeView.swift
//  TrendyFilms
//
//  Created by Óscar on 2/7/22.
//

import UIKit
import RxSwift
import RxCocoa

class HomeView: UIViewController {
  
  @IBOutlet weak var filmsTable: UITableView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  var homeViewModel = HomeViewModel()
  var homeRouter = HomeRouter()
  var films = [Film]()
  var searchedFilms = [Film]()
  var disposeBag = DisposeBag()
  lazy var searchController = SearchController()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.title = "Trendy Films List"
    filmsTable.delegate = self
    filmsTable.dataSource = self
    setTableView()
    homeViewModel.bind(view: self, router: homeRouter)
    getData()
    setSearchBar()
  }
  
  func setTableView(){
    filmsTable.rowHeight = UITableView.automaticDimension
    filmsTable.register(UINib(nibName: "FilmCell", bundle: nil), forCellReuseIdentifier: "FilmCell")
  }
  
  func updateTableView() {
    
    DispatchQueue.main.async {
      
      self.activityIndicator.stopAnimating()
      self.activityIndicator.isHidden = true
      self.filmsTable.reloadData()
      
    }
  }
  
  func getData() {
    
    return homeViewModel.getFilms()
      .subscribe(on: MainScheduler.instance)
      .observe(on: MainScheduler.instance)
      .subscribe { films in
        self.films = films
        self.updateTableView()
      } onError: { error in
        print(error)
      }
      .disposed(by: disposeBag)
    
  }
  
  func setSearchBar() {
    
    let searchBar = searchController.searchBar
    searchBar.delegate = self
    navigationItem.searchController = searchController
    
    searchBar.rx.text.orEmpty.distinctUntilChanged()
      .subscribe { result in
        self.searchedFilms = self.films.filter({ film in
          self.updateTableView()
          return film.title.contains(result)
        })
      } onError: { error in
        print(error)
      }
      .disposed(by: disposeBag)

  }

}

//MARK: - UITableViewDataSource

extension HomeView: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if searchController.isActive && !searchController.searchBar.text!.isEmpty {
      return searchedFilms.count
    } else {
      return films.count
    }
    
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = filmsTable.dequeueReusableCell(withIdentifier: "FilmCell") as! FilmCell
    
    if searchController.isActive && !searchController.searchBar.text!.isEmpty {
      
      cell.filmTitle.text = searchedFilms[indexPath.row].title
      cell.filmRating.text = "Rating: " + String(searchedFilms[indexPath.row].rating)
      cell.filmOverview.text = searchedFilms[indexPath.row].overview
      cell.filmImage.getFilmImage(from: Utils.URL.baseImageUrl+searchedFilms[indexPath.row].imagePath, placeHolder: UIImage(named: "NoImage")!)
      
    } else {
      
      cell.filmTitle.text = films[indexPath.row].title
      cell.filmRating.text = "Rating: " + String(films[indexPath.row].rating)
      cell.filmOverview.text = films[indexPath.row].overview
      cell.filmImage.getFilmImage(from: Utils.URL.baseImageUrl+films[indexPath.row].imagePath, placeHolder: UIImage(named: "NoImage")!)
      
    }
    
    return cell
    
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 200
  }
  
}

//MARK: - UITableViewDelegate

extension HomeView: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    var film = films[indexPath.row]
    if searchController.isActive, searchController.searchBar.text != "" {
      film = searchedFilms[indexPath.row]
    }
    homeRouter.openDetailView(filmId: String(film.id))
  }
}

//MARK: - UISearchBarDelegate

extension HomeView: UISearchBarDelegate {
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    guard films.count == searchedFilms.count else { return }
    updateTableView()
  }
}
