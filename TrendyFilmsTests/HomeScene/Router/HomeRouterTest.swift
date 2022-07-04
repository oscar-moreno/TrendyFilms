//
//  HomeRouterTest.swift
//  TrendyFilmsTests
//
//  Created by Óscar on 4/7/22.
//

import XCTest
@testable import TrendyFilms

class HomeRouterTest: XCTestCase {
  
  func testHomeCreateViewControllerMustBeConfiguredWithHomeView() throws {
    let homeRouter = HomeRouter()
    let homeView = homeRouter.createViewController()
    
    XCTAssertTrue(homeView.nibName == "HomeView")
    XCTAssertTrue(homeView.nibBundle == Bundle.main)
  }

}
