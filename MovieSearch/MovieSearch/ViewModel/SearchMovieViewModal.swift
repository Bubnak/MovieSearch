//
//  SearchMovieViewModal.swift
//  MovieSearch
//
//  Created by Bubna Ratheesh on 30/01/2021.
//  Copyright © 2021 Bubna Kbubna. All rights reserved.
//

import Foundation
import UIKit

protocol SearchMovieViewModalDelegate: class {
  func onFetchCompleted(with title:[String], andUrl:[String], imdbID:[String])
  func onFetchImage()
  func onFetchFailed(with reason: String)
}

class SearchMovieViewModal{
     private weak var delegate: SearchMovieViewModalDelegate?
     var service = Service()
    init( delegate: SearchMovieViewModalDelegate) {
      self.delegate = delegate
    }
    
    
    func createString(with str:String) ->  String {
        let components = str.components(separatedBy: " ")
        print(components)
        var newStr :String = ""
        var i :Int = 0
        for val in components{
            print(val)
            if(i>0){
            newStr = newStr+"%20"+val
            }else{
                newStr = newStr+val
            }
            i = i + 1
        }
        if(newStr .isEmpty){
            newStr = str
        }
        return newStr
    }
    func urlSessionVM(with searchTxt:String) {
        
       // let str = "Hello! Swift String."
       let searchValue = createString(with: searchTxt)
        service.urlSessionSearchList(with: searchValue){ (res) in
            switch res {
            case .success(let movieLists):
            var arrUrl :[String] = []
            var arrTitle :[String] = []
            var arrImdbID :[String] = []
            movieLists.forEach({ (movieList) in
                arrUrl.append(movieList.Poster)
                arrTitle.append(movieList.Title)
                arrImdbID.append(movieList.imdbID)
                })
            self.delegate?.onFetchCompleted(with: arrTitle, andUrl: arrUrl, imdbID:arrImdbID)
            case .failure(let err):
                self.delegate?.onFetchFailed(with: "Failed to search movie")
                print("Failed to fetch :", err)
            }
        }
    }
    
   func getImage(withURL url:URL, completion: @escaping (_ image:UIImage?)->()) {
          if let image = Service.cache.object(forKey: url.absoluteString as NSString) {
              completion(image)
          } else if (url == URL(string:  "N/A")){
            let image = UIImage(named: "noImage.png")
             completion(image)
          }
          else{
              Service.downloadImage(withURL: url, completion: completion)
            self.delegate?.onFetchImage()
          }
      }
}

