//
//  Builder.swift
//  Movie_Collection
//
//  Created by Admin on 29.03.2020.
//  Copyright © 2020 none. All rights reserved.
//

import UIKit

protocol Builder {
    static func createMainController() -> UIViewController
}

class ControllerBuilder: Builder {
    static func createMainController() -> UIViewController {
        let viewController = MainViewController()
        let movieService = MovieService()
        let presenter = MainPresenter(view: viewController,
                                      movieService: movieService)
        viewController.presenter = presenter
        return viewController
    }
}
