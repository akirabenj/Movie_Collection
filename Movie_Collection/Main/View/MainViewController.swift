//
//  MainViewController.swift
//  Movie_Collection
//
//  Created by Admin on 29.03.2020.
//  Copyright © 2020 none. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    @IBOutlet private weak var loadIndicator: UIActivityIndicatorView!
    
    var presenter: MainPresenterProtocol!
    private var movies: [Movie] {
        if let result = presenter?.movies {
            return result
        } else {
            return [Movie]()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isUserInteractionEnabled = false
        self.title = "MARVEL"
        tableView.isHidden = true
        self.tableView.register(UINib(nibName: "MoviesTableViewCell", bundle: nil), forCellReuseIdentifier: "movieCell")
        // Do any additional setup after loading the view.
    }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as? MoviesTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setCell(movie: movies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !movies.isEmpty {
            let detailsView = ModuleBuilder.createDetailsModule(movie: movies[indexPath.row])
            self.navigationController?.pushViewController(detailsView, animated: true)
        }
    }
}

extension MainViewController: MainViewProtocol {
    func success() {
        tableView.isHidden = false
        self.view.isUserInteractionEnabled = true
        loadIndicator.stopAnimating()
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}
