//
//  Utils.swift
//  TrendyFilms
//
//  Created by Óscar on 2/7/22.
//

import Foundation

enum Utils {
  
  static let apiKeyParameter = "?api_key="
  static let apiKey = "4909e64e74dc2592f7bb124464e35328"
  
  enum URL {
    static let baseFilmUrl = "https://api.themoviedb.org"
    static let baseImageUrl = "https://image.tmdb.org/t/p/w200"
  }
  
  enum EndPoints {
    static let popularFilms = "/3/movie/popular"
    static let detailFilm = "/3/movie/"
  }
  
  enum Responses {
    static let successResponse = "INFO: Successful response (Code 200)"
    static let forbidenResponse = "ERROR: Access not authorized (Code 401)"
    static let unknownError = "ERROR: Uknown error in request"
  }
  
}
