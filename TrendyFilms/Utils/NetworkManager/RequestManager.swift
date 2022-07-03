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
      
      let popularFilmsUrl = URL(string: Utils.URL.baseFilmUrl+Utils.EndPoints.popularFilms+Utils.apiKeyParameter+Utils.apiKey)!
      let session = URLSession.shared
      let request = URLRequest(url: popularFilmsUrl)
      
      session.dataTask(with: request) { (data, response, error) in
        
        guard let data = data, let response = response as? HTTPURLResponse, error == nil else { return }
        
        switch response.statusCode {
        case 200:
          print("INFO: Successful response (Code 200)")
          self.parseJsonFilms(source: data, to: observer)
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
  
  func parseJsonFilms(source data: Data, to observer: AnyObserver<[Film]>) {
    
    do {
      let decoder = JSONDecoder()
      let films = try decoder.decode(Films.self, from: data)
      
      observer.onNext(films.Films)
      
    } catch let error{
      observer.onError(error)
      print("ERROR: Error parsing films data -> \(error.localizedDescription)")
    }
    
  }
  
  func getFilmDetail(_ filmId: String) -> Observable<FilmDetail> {
    
    return Observable.create { observer in
      
      let filmUrl = URL(string: Utils.URL.baseFilmUrl+Utils.EndPoints.detailFilm+filmId+Utils.apiKeyParameter+Utils.apiKey )!
      let session = URLSession.shared
      let request = URLRequest(url: filmUrl)
      
      session.dataTask(with: request) { (data, response, error) in
        
        guard let data = data, let response = response as? HTTPURLResponse, error == nil else { return }
        
        switch response.statusCode {
        case 200:
          print("INFO: Successful response (Code 200)")
          self.parseJsonFilmDetail(source: data, to: observer)
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
  
  func parseJsonFilmDetail(source data: Data, to observer: AnyObserver<FilmDetail>) {
    
    do {
      let decoder = JSONDecoder()
      let film = try decoder.decode(FilmDetail.self, from: data)
      
      observer.onNext(film)
      
    } catch let error{
      observer.onError(error)
      print("ERROR: Error parsing films data -> \(error.localizedDescription)")
    }
    
  }
  
  func getFilmImage(from imageUrl: String) -> Observable<UIImage> {
    return Observable.create { observer in
      
      let placeHolderImage = UIImage(named: "NoImage")!
      
      URLSession.shared.dataTask(with: NSURL(string: imageUrl)! as URL, completionHandler: { (data, response, error) -> Void in
        
        guard let data = data, let response = response as? HTTPURLResponse, error == nil else { return }
        
        switch response.statusCode {
        case 200:
          print("INFO: Successful response (Code 200)")
          guard let image = UIImage(data: data) else { return }
          observer.onNext(image)
        case 401:
          print("ERROR: Access not authorized (Code 401)")
          observer.onNext(placeHolderImage)
        default:
          print("ERROR: Uknown error in request. No image")
          observer.onNext(placeHolderImage)
        }
                
        observer.onCompleted()
        
      }).resume()
      
      //MARK: return our disposable
      return Disposables.create {}
      
    }
  }
  
}
