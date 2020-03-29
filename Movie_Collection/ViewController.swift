//
//  ViewController.swift
//  Movie_Collection
//
//  Created by Admin on 26.03.2020.
//  Copyright © 2020 none. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    private let movieService = MovieService()
    private var movies = [Movie]()

    @IBOutlet private weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //registerCell()
        movieService.getMovies { [weak self] (fetchedResult, error) in
            if let error = error {
                print(error)
                return
            }
            if let movies = fetchedResult {
                DispatchQueue.main.async {
                    self?.movies = movies
                    self?.tableView.reloadData()
                }
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableCell else {
            return MovieTableCell()
        }
        
        cell.setCell(movie: movies[indexPath.row])
        return cell
    }
    
    func registerCell() {
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "movieCell")
    }
}
