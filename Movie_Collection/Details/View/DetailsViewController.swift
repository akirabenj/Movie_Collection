//
//  DetailsViewController.swift
//  Movie_Collection
//
//  Created by Admin on 30.03.2020.
//  Copyright © 2020 none. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var presenter: DetailsPresenterProtocol!
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var overviewText: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setView() {
        poster.downloadImage(with: presenter.movie.posterPath ?? "")
        titleLabel.text = presenter.movie.title
        rateLabel.text = String(presenter.movie.rate ?? 0.0)
        releaseDateLabel.text = presenter.movieDetails?.releaseDate
        var genresText = ""
        presenter.movieDetails?.genres.forEach({ (genre) in
                genresText += "\(genre) "
        })
        genresLabel.text = genresText
        taglineLabel.text = presenter.movieDetails?.tagline
        overviewText.text = presenter.movieDetails?.overview
    }

}

extension DetailsViewController: DetailsViewProtocol {
    func setDetails() {
        setView()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}
