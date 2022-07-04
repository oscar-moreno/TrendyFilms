//
//  HomeRouterTest.swift
//  TrendyFilmsTests
//
//  Created by Óscar on 4/7/22.
//

import XCTest
@testable import TrendyFilms

class DetailRouterTest: XCTestCase {
  
  func testDetailCreateViewControllerMustBeConfiguredWithHomeView() throws {
    let detailRouter = DetailRouter()
    let detailView = detailRouter.createViewController()
    
    XCTAssertTrue(detailView.nibName == "DetailView")
    XCTAssertTrue(detailView.nibBundle == Bundle.main)
  }

}
