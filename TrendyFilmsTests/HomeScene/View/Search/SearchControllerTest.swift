//
//  SearchControllerTest.swift
//  TrendyFilmsTests
//
//  Created by Óscar on 4/7/22.
//

import XCTest
@testable import TrendyFilms

class SearchControllerTest: XCTestCase {

  func testSearchControllerMustBeInitializedWithRightProperties() throws {
    
    let searchController = SearchController()
    
    XCTAssertTrue(searchController.hidesNavigationBarDuringPresentation)
    XCTAssertEqual(searchController.searchBar.barStyle, .default)
    XCTAssertEqual(searchController.searchBar.placeholder, "Search a film...")
    
  }

}
