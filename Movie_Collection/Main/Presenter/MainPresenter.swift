//
//  MainViewPresenter.swift
//  Movie_Collection
//
//  Created by Admin on 29.03.2020.
//  Copyright © 2020 none. All rights reserved.
//

import Foundation

protocol MainViewProtocol: class {
    func success()
    func failure(error: Error)
}

protocol MainPresenterProtocol: class {
    init(view: MainViewProtocol, movieService: MovieServiceProtocol)
    
    var movies: [Movie]? { get set }
    
    func getMovies()
}

class MainPresenter: MainPresenterProtocol {
    
    var movies: [Movie]?
    weak var view: MainViewProtocol?
    weak var service: MovieServiceProtocol?
    
    required init(view: MainViewProtocol, movieService: MovieServiceProtocol) {
        self.view = view
        self.service = movieService
        getMovies()
    }
    
    func getMovies() {
        service?.getMovies(completion: { [weak self] (movies, error) in
            DispatchQueue.main.async {
                if let error = error {
                    self?.view?.failure(error: error)
                    return
                } else {
                    if let movies = movies {
                        self?.movies = movies
                        self?.view?.success() // if movies fetched call success function by delegate
                    }
                }
            }
        })
    }
    
    
    
}
