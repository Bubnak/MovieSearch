//
//  SearchMovieViewModal.swift
//  MovieSearch
//
//  Created by Bubna Ratheesh on 30/01/2021.
//  Copyright © 2021 Bubna Kbubna. All rights reserved.
//

import Foundation
import UIKit

protocol MovieDetailViewModalDelegate: class {
  func onFetchCompleted(with movieDetail:MovieDetail)
     func onFetchImage(with Image: UIImage )
  func onFetchFailed(with reason: String)
}

class MovieDetailViewModal{
     private weak var delegate: MovieDetailViewModalDelegate?
     var service = Service()
    init( delegate: MovieDetailViewModalDelegate) {
      self.delegate = delegate
    }
    
    

    func urlMovieDetail(with imdbID:String) {
        service.urlSessionSearchDetails(with: imdbID) { (res) in
            switch res {
            case .success(let movieDetail):
          
            self.delegate?.onFetchCompleted(with: movieDetail)
            case .failure(let err):
                print("Failed to fetch courses:", err)
            }
        }

    }
    

}

