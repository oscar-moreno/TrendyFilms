//
//  DetailRouter.swift
//  TrendyFilms
//
//  Created by Óscar on 3/7/22.
//

import Foundation
import UIKit

class DetailRouter {
  
  var sourceView: UIViewController?
  var filmId: String?
  var detailViewController: UIViewController {
      return createViewController()
  }
  
  init(filmId: String? = "") {
    self.filmId = filmId
  }
  
  func createViewController() -> UIViewController {
    let detailView = DetailView(nibName: "DetailView", bundle: Bundle.main)
    detailView.filmId = self.filmId
    return detailView
  }
  
  func setSourceView(_ sourceView: UIViewController?) {
    guard let detailView = sourceView else {fatalError("Unkown error")}
    self.sourceView = detailView
  }
}
