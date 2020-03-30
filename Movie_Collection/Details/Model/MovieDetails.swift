//
//  MovieDetails.swift
//  Movie_Collection
//
//  Created by Admin on 29.03.2020.
//  Copyright © 2020 none. All rights reserved.
//

import Foundation

struct MovieDetails {
    var genres: [String]
    var overview: String
    var releaseDate: String
    var tagline: String
    
    init(jsonDict: [String: Any], genres: [String]) {
        self.genres = genres
        overview = jsonDict["overview"] as? String ?? ""
        releaseDate = jsonDict["release_date"] as? String ?? ""
        tagline = jsonDict["tagline"] as? String ?? ""
    }
}
