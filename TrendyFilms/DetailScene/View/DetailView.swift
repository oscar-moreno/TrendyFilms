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
  @IBOutlet weak var filmGenres: UILabel!
  @IBOutlet weak var filmWebsite: UILabel!
  @IBOutlet weak var filmOriginalLanguage: UILabel!
  @IBOutlet weak var filmBudget: UILabel!
  @IBOutlet weak var filmRevenue: UILabel!
  
  var filmId: String?
  var detailViewModel = DetailViewModel()
  var detailRouter = DetailRouter()
  var disposeBag = DisposeBag()
  var cachedFilms: [FilmDetail] = []
  
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
        self.cachedFilms.append(film)
        self.displayFilmData(film.id)
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
  
  func displayFilmData(_ filmId: Int) {
    DispatchQueue.main.async {
      let filmToDisplay = self.cachedFilms.filter{$0.id == filmId}
      self.getFilmImage(for: filmToDisplay[0])
      self.filmTitle.text = filmToDisplay[0].title
      self.filmOverview.text = filmToDisplay[0].overview
      self.filmRating.text = "Rating: \(String(filmToDisplay[0].rating))"
      self.filmReleaseDate.text = "Release date: \(filmToDisplay[0].releaseDate)"
      
      var genres = [String]()
      for genre in filmToDisplay[0].genres {
        genres.append(genre.name)
      }
      self.filmGenres.text = "Generes: \(genres.joined(separator: ", "))"
      
      self.filmWebsite.text = "Website: \(filmToDisplay[0].website)"
      self.filmOriginalLanguage.text = "Original language: \(filmToDisplay[0].originalLanguage)"
      self.filmBudget.text = "Bugget: \(filmToDisplay[0].budget)"
      self.filmRevenue.text = "Revenue: \(filmToDisplay[0].revenue)"
      
    }
  
  }
  
}
