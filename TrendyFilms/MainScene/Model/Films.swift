//
//  Film.swift
//  TrendyFilms
//
//  Created by Óscar on 2/7/22.
//

import Foundation

struct Films: Codable {
  
  let films: [Film]
  
  enum CodingKeys: String, CodingKey {
    case films = "results"
  }
  
}

struct Film: Codable {
  
  let id: Int
  let title: String
  let overview: String
  let rating: Double
  let imagePath: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case title
    case overview
    case rating = "vote_average"
    case imagePath = "poster_path"
  }
  
}
