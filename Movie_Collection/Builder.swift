//
//  Builder.swift
//  Movie_Collection
//
//  Created by Admin on 29.03.2020.
//  Copyright © 2020 none. All rights reserved.
//

import UIKit

protocol Builder {
    static func createMainModule() -> UIViewController
    static func createDetailsModule(movie: Movie) -> UIViewController
}

class ModuleBuilder: Builder {
    private static let movieService = MovieService()
    
    static func createMainModule() -> UIViewController {
        let viewController = MainViewController()
        let presenter = MainPresenter(view: viewController,
                                      movieService: self.movieService)
        viewController.presenter = presenter
        return viewController
    }
    
    static func createDetailsModule(movie: Movie) -> UIViewController {
        let viewController = DetailsViewController()
        let presenter = DetailsPresenter(view: viewController,
                                         movieService: self.movieService,
                                         movie: movie)
        viewController.presenter = presenter
        return viewController
    }
}
