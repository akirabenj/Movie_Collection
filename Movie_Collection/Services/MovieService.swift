//
//  NetworkService.swift
//  Movie_Collection
//
//  Created by Admin on 27.03.2020.
//  Copyright © 2020 none. All rights reserved.
//

import Foundation

protocol MovieServiceProtocol: class {
    func getMovies(completion: @escaping ([Movie]?, Error?) -> Void)
    func getMovieDetails(id: Int, completion: @escaping (MovieDetails?, Error?) -> Void)
}

class MovieService: MovieServiceProtocol {
    
    private let apiKey = "22bde7605a09dd12a349031109d8ea62"
    
    func getMovies(completion: @escaping ([Movie]?, Error?) -> Void) {
        let urlString = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&language=en-US&query=marvel&page=1&include_adult=true"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let data = data {
                do {
                    // fetch json from url
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] else {
                        return
                    }
                    var movies = [Movie]()
                    // separate "results" field from fetched json
                    guard let resultsData = json["results"] as? [[String: Any]] else {
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
                    completion(nil, error)
                    print(error.localizedDescription)
                }
            }
            
        }.resume()
    }
    
    func getMovieDetails(id: Int, completion: @escaping (MovieDetails?, Error?) -> Void) {
        let urlString = "https://api.themoviedb.org/3/movie/\(id)?api_key=22bde7605a09dd12a349031109d8ea62&language=en-US"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let data = data {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] else {
                        return
                    }
                    var genres = [String]()
                    // separate "genres" field from fetched json
                    if let fetchedGenres = json["genres"] as? [[String: Any]] {
                        fetchedGenres.forEach({ (genre) in
                            guard let name = genre["name"] as? String else { return }
                            genres.append(name)
                        })
                    }
                    completion(MovieDetails(jsonDict: json, genres: genres), nil)
                } catch {
                    print(error.localizedDescription)
                    completion(nil, error)
                }
            }
        }.resume()
    }
}
