//
//  DetailViewModel.swift
//  TrendyFilms
//
//  Created by Óscar on 3/7/22.
//

import Foundation
import RxSwift

class DetailViewModel {
  
  var requestManager = RequestManager()
  var detailView: DetailView?
  var detailRouter: DetailRouter?
  
  func bind(view: DetailView, router: DetailRouter) {
    self.detailView = view
    self.detailRouter = router
    self.detailRouter?.setSourceView(view)
  }
  
  func getFilmInfo(filmId: String) -> Observable<FilmDetail> {
    return requestManager.getFilmDetail(filmId)
  }
  
  func getFilmImage(imageUrl: String) -> Observable<UIImage> {
    return requestManager.getFilmImage(from: imageUrl)
  }
  
}
