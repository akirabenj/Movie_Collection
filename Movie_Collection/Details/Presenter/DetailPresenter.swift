//
//  DetailPresenter.swift
//  Movie_Collection
//
//  Created by Admin on 30.03.2020.
//  Copyright © 2020 none. All rights reserved.
//

import UIKit

protocol DetailsViewProtocol: class {
    func setDetails()
    func failure(error: Error)
}

protocol DetailsPresenterProtocol: class {
    
    init(view: DetailsViewProtocol,
         movieService: MovieServiceProtocol,
         movie: Movie)
    
    var movieDetails: MovieDetails? { get set }
    var movie: Movie { get set }
    func setDetails()
}

class DetailsPresenter: DetailsPresenterProtocol {
    
    var movieDetails: MovieDetails?
    weak var view: DetailsViewProtocol?
    weak var movieService: MovieServiceProtocol?
    var movie: Movie
    
    required init(view: DetailsViewProtocol, movieService: MovieServiceProtocol, movie: Movie) {
        self.view = view
        self.movieService = movieService
        self.movie = movie
        setDetails()
    }
    
    func setDetails() {
        movieService?.getMovieDetails(id: movie.id, completion: { [weak self] (details, error) in
            DispatchQueue.main.async {
                if let error = error {
                    self?.view?.failure(error: error)
                } else if let details = details {
                    self?.movieDetails = details
                    self?.view?.setDetails()
                }
            }
        })
    }
}
