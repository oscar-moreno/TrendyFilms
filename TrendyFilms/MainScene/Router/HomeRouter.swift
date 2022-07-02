//
//  HomeRouter.swift
//  TrendyFilms
//
//  Created by Óscar on 2/7/22.
//

import Foundation
import UIKit

class HomeRouter {
  
  var sourceView: UIViewController?
  
  var homeViewController: UIViewController {
    return createViewController()
  }
  
  func createViewController() -> UIViewController {
    let homeView = HomeView(nibName: "HomeView", bundle: Bundle.main)
    return homeView
  }
  
  func setSourceView(_ sourceView: UIViewController?) {
    guard let homeView = sourceView else {fatalError("Unkown error")}
    self.sourceView = homeView
  }
  
}
