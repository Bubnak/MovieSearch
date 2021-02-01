//
//  MovieSearch.swift
//  MovieSearch
//
//  Created by Bubna Ratheesh on 30/01/2021.
//  Copyright © 2021 Bubna Kbubna. All rights reserved.
//

import Foundation
struct Results: Decodable {
let Search :[ResultOne]
    let totalResults: String
     let Response: String
    
    
}
struct ResultOne:Decodable {
let imdbID: String
 let Year: String
 let Title: String
let `Type`: String
let Poster: String

    
}
