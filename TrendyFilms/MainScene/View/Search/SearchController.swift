//
//  SearchController.swift
//  TrendyFilms
//
//  Created by Óscar on 3/7/22.
//

import UIKit

class SearchController: UISearchController {
  init() {
    super.init(searchResultsController: nil)
    configureSearchController()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension SearchController {
  func configureSearchController() {
    hidesNavigationBarDuringPresentation = true
    searchBar.sizeToFit()
    searchBar.barStyle = .default
    searchBar.placeholder = "Search a film..."
  }
}
