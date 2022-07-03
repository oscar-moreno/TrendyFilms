//
//  DetailViewController.swift
//  TrendyFilms
//
//  Created by Óscar on 3/7/22.
//

import UIKit
import RxSwift

class DetailView: UIViewController {
  
  @IBOutlet weak var filmImage: UIImageView!
  @IBOutlet weak var filmTitle: UILabel!
  @IBOutlet weak var filmOverview: UILabel!
  @IBOutlet weak var filmRating: UILabel!
  @IBOutlet weak var filmReleaseDate: UILabel!
  @IBOutlet weak var filmGeneres: UILabel!
  @IBOutlet weak var filmWebsite: UILabel!
  @IBOutlet weak var filmOriginalLanguage: UILabel!
  @IBOutlet weak var filmBudget: UILabel!
  @IBOutlet weak var filmRevenue: UILabel!
  
  var filmId: String?
  var detailViewModel = DetailViewModel()
  var detailRouter = DetailRouter()
  var disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    detailViewModel.bind(view: self, router: detailRouter)
    getFilmDetail()
  }
  
  private func getFilmDetail() {
    guard let safeIdFilm = filmId else { return }
    return detailViewModel.getFilmInfo(filmId: safeIdFilm)
      .subscribe(on: MainScheduler.instance)
      .observe(on: MainScheduler.instance)
      .subscribe { film in
        self.displayFilmData(film: film)
      } onError: { error in
        print(error)
      } onCompleted: { }
      .disposed(by: disposeBag)
  }
  
  func getFilmImage(for film: FilmDetail) {
    return detailViewModel.getFilmImage(imageUrl: Utils.URL.baseImageUrl+film.imagePath)
      .subscribe(
        onNext: { image in
          DispatchQueue.main.sync {
            self.filmImage.image = image
          }
        },
        onError: { error in
          print(error.localizedDescription)
        },
        onCompleted: {
        }).disposed(by: disposeBag)
  }
  
  func displayFilmData(film: FilmDetail) {
    DispatchQueue.main.async {
      self.getFilmImage(for: film)
      self.filmTitle.text = film.title
      self.filmOverview.text = film.overview
      self.filmRating.text = "Rating: \(String(film.rating))"
      self.filmReleaseDate.text = "Release date: \(film.releaseDate)"
      
      var genres = [String]()
      for genre in film.genres {
        genres.append(genre.name)
      }
      self.filmGeneres.text = "Generes: \(genres.joined(separator: ", "))"
      
      self.filmWebsite.text = "Website: \(film.website)"
      self.filmOriginalLanguage.text = "Original language: \(film.originalLanguage)"
      self.filmBudget.text = "Bugget: \(film.budget)"
      self.filmRevenue.text = "Revenue: \(film.revenue)"
      
    }
  }
  
}
