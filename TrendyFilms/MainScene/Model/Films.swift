//
//  Film.swift
//  TrendyFilms
//
//  Created by Óscar on 2/7/22.
//

import Foundation

struct Films: Codable {
  
  let Films: [Film]
  
  enum CodingKeys: String, CodingKey {
    case Films = "results"
  }
  
}

struct Film: Codable {
  
  let id: Int
  let title: String
  let overview: String
  let rating: Double
  let imageUrl: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case title
    case overview
    case rating = "vote_average"
    case imageUrl = "poster_path"
  }
  
}
