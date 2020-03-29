//
//  NetworkService.swift
//  Movie_Collection
//
//  Created by Admin on 27.03.2020.
//  Copyright © 2020 none. All rights reserved.
//

import Foundation

protocol MovieServiceProtocol {
    func getMovies(completion: @escaping ([Movie]?, Error?) -> Void)
}

class MovieService: MovieServiceProtocol {
    
    private let apiKey = "22bde7605a09dd12a349031109d8ea62"
    
    func getMovies(completion: @escaping ([Movie]?, Error?) -> Void) {
        let urlString = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&language=en-US&query=marvel&page=1&include_adult=true"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let data = data {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] else {
                        return
                    }
                    var movies = [Movie]()
                    guard let resultsData = json["results"] as? [[String: Any]] else
                    {
                        return
                        
                    }
                    resultsData.forEach({ (dict) in
                        let dict: [String: Any?] = ["id": dict["id"],
                                                   "title": dict["title"],
                                                   "poster_path": dict["poster_path"],
                                                   "average_vote": dict["vote_average"]]
                        
                        movies.append(Movie(jsonDict: dict))
                    })
                    
                    completion(movies, nil)
                } catch {
                    print(error.localizedDescription)
                }
            }
            
        }.resume()
    }
    
    func getMovieDetails(id: Int) {
        
    }
}
