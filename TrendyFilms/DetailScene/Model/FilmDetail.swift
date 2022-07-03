//
//  FilmDetail.swift
//  TrendyFilms
//
//  Created by Óscar on 3/7/22.
//

import Foundation

struct FilmDetail: Codable {
  
  let id: Int
  let imagePath: String
  let title: String
  let overview: String
  let rating: Double
  let releaseDate: String
  let genres: [genre]
  let website: String
  let originalLanguage: String
  let budget: Int
  let revenue: Int
  
  enum CodingKeys: String, CodingKey {
    
    case id
    case imagePath = "poster_path"
    case title
    case overview
    case rating = "vote_average"
    case releaseDate = "release_date"
    case genres
    case website = "homepage"
    case originalLanguage = "original_language"
    case budget
    case revenue
    
  }
  
}

struct genre: Codable {
  let id: Int
  let name: String
}
