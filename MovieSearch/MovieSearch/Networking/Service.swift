//
//  Service.swift
//  IOSCollectionViewControllerTutorial
//
//  Created by Bubna Ratheesh on 30/01/2021.
//  Copyright © 2021 Arthur Knopper. All rights reserved.
//

import Foundation
import UIKit



class Service: NSObject {
    
    var errorMessage = ""
     let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    
  
func urlSessionSearchList(with searchTxt:String, completion: @escaping (Result<[ResultOne], Error>) -> ()) {
    //
    if let urlComponents = URLComponents(string: msURLSearchList+searchTxt+"&type=movie") {
        guard let url = urlComponents.url else { return }
        // 4
        dataTask = defaultSession.dataTask(with: url) { data, response, err in
            
            defer { self.dataTask = nil }
            
            
            if let err = err {
                            completion(.failure(err))
                            return
                        }
                        
                        do {
                            let movieLists = try JSONDecoder().decode(Results.self, from: data!)
                            completion(.success(movieLists.Search))
          
                        } catch let jsonError {
                            completion(.failure(jsonError))
        
                        }
           
        }
        dataTask?.resume()
    }
    
    }
    
    func urlSessionSearchDetails(with imdbID:String, completion: @escaping (Result<MovieDetail, Error>) -> ()) {
    
    if let urlComponents = URLComponents(string: msURLSearchDetail+imdbID) {
        guard let url = urlComponents.url else { return }
        // 4
        dataTask = defaultSession.dataTask(with: url) { data, response, err in
            
            defer { self.dataTask = nil }
            
            
            if let err = err {
                            completion(.failure(err))
                            return
                        }
                        
                        do {
                            let movieLists = try JSONDecoder().decode(MovieDetail.self, from: data!)
                            completion(.success(movieLists))
          
                        } catch let jsonError {
                            completion(.failure(jsonError))
        
                        }
           
        }
        dataTask?.resume()
    }
    
    }
    
    
    
    static let cache = NSCache<NSString, UIImage>()
    
    static func downloadImage(withURL url:URL, completion: @escaping (_ image:UIImage?)->()) {
        let dataTask = URLSession.shared.dataTask(with: url) { data, responseURL, error in
            var downloadedImage:UIImage?
            
            if let data = data {
                downloadedImage = UIImage(data: data)
            }
            
            if downloadedImage != nil {
                cache.setObject(downloadedImage!, forKey: url.absoluteString as NSString)
            }
            
            DispatchQueue.main.async {
                completion(downloadedImage)
            }
            
        }
        
        dataTask.resume()
    }
    

    }
    
    


