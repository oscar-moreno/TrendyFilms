//
//  HomeView.swift
//  TrendyFilms
//
//  Created by Óscar on 2/7/22.
//

import UIKit
import RxSwift

class HomeView: UIViewController {
  
  @IBOutlet weak var filmsTable: UITableView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  var homeViewModel = HomeViewModel()
  var homeRouter = HomeRouter()
  var films = [Film]()
  var disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setTableView()
    homeViewModel.bind(view: self, router: homeRouter)
    getData()
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
      } onCompleted: { }
      .disposed(by: disposeBag)
  }

}

//MARK: - UITableViewDataSource

extension HomeView: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return films.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = filmsTable.dequeueReusableCell(withIdentifier: "FilmCell") as! FilmCell
    cell.filmTitle.text = films[indexPath.row].title
    cell.filmRating.text = "Rating: " + String(films[indexPath.row].rating)
    cell.filmOverview.text = films[indexPath.row].overview
    cell.filmImage.getFilmImage(from: "\(Utils.URL.baseImageUrl)\(films[indexPath.row].imageUrl)", placeHolder: UIImage(named: "NoImage")!)
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 200
  }
  
}
