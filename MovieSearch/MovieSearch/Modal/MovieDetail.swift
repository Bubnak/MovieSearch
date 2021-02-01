//
//  MovieDetail.swift
//  MovieSearch
//
//  Created by Bubna Ratheesh on 31/01/2021.
//  Copyright © 2021 Bubna Kbubna. All rights reserved.
//

import Foundation
struct MovieDetail:Decodable {
   
    let Title: String
     let Year: String
     let Genre: String
    let Plot: String
    
    let Director: String
        let Writer: String
         let Actors: String
    
         let imdbRating: String
        let imdbVotes: String
        let Poster: String
    let imdbID: String

    
}
