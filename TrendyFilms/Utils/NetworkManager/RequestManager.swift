//
//  RequestManager.swift
//  TrendyFilms
//
//  Created by Óscar on 2/7/22.
//

import Foundation
import RxSwift

class RequestManager {
  
  func getPopularFilms() -> Observable<[Film]> {
    
    return Observable.create { observer in
      
      let popularFilmsUrl = URL(string: Utils.URL.baseFilmUrl+Utils.EndPoints.popularFilms+Utils.apiKeyParameter+Utils.apiKey )!
      let session = URLSession.shared
      let request = URLRequest(url: popularFilmsUrl)
      
      session.dataTask(with: request) { (data, response, error) in
        
        guard let data = data, let response = response as? HTTPURLResponse, error == nil else { return }
        
        switch response.statusCode {
        case 200:
          print("INFO: Successful response (Code 200)")
          self.parseJson(source: data, to: observer)
        case 401:
          print("ERROR: Access not authorized (Code 401)")
        default:
          print("ERROR: Uknown error in request")
        }
        
        observer.onCompleted()
        
      }.resume()
      
      return Disposables.create{
        session.finishTasksAndInvalidate()
      }
      
    }
    
  }
  
  func parseJson(source data: Data, to observer: AnyObserver<[Film]>) {
    
    do {
      let decoder = JSONDecoder()
      let films = try decoder.decode(Films.self, from: data)
      
      observer.onNext(films.Films)
      
    } catch let error{
      observer.onError(error)
      print("ERROR: Error parsing films data -> \(error.localizedDescription)")
    }
    
  }
  
}
