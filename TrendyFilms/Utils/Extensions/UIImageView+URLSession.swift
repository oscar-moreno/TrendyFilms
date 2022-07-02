//
//  UIImageView+URLSession.swift
//  TrendyFilms
//
//  Created by Óscar on 2/7/22.
//

import UIKit

extension UIImageView {
  
  func getFilmImage(from url: String, placeHolder: UIImage) {
    
    if self.image == nil {
      self.image = placeHolder
    }
    
    URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
      if error != nil {
        return
      }
      
      DispatchQueue.main.async {
        guard let safeData = data else { return }
        let image = UIImage(data: safeData)
        self.image = image
      }
      
    }.resume()
    
  }
  
}
