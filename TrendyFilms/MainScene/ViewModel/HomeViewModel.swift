//
//  HomeViewModel.swift
//  TrendyFilms
//
//  Created by Óscar on 2/7/22.
//

import Foundation
import RxSwift

class HomeViewModel {
  
  var homeView: HomeView?
  var homeRouter: HomeRouter?
  
  var requestManager = RequestManager()
  
  func bind(view: HomeView, router: HomeRouter) {
    self.homeView = view
    self.homeRouter = router
    self.homeRouter?.setSourceView(view)
  }
  
  func getFilms() -> Observable<[Film]> {
    return requestManager.getPopularFilms()
  }
  
}

