//
//  Movie.swift
//  Movie_Collection
//
//  Created by Admin on 26.03.2020.
//  Copyright © 2020 none. All rights reserved.
//

import Foundation

struct Movie {
    var id: Int
    var title: String?
    var posterPath: String?
    var rate: Double?
    
    init(jsonDict: [String: Any?]) {
        id = jsonDict["id"] as? Int ?? 0
        title = jsonDict["title"] as? String ?? ""
        posterPath = jsonDict["poster_path"] as? String ?? ""
        rate = jsonDict["average_vote"] as? Double ?? 0.0
    }
}

struct MovieInfo {
    var cast: [String]
    var genres: [String]
    var director: String
}
