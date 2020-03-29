//
//  UIExtensions.swift
//  Movie_Collection
//
//  Created by Admin on 29.03.2020.
//  Copyright © 2020 none. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func downloadImage(with path: String) {
        let stringURL = "https://image.tmdb.org/t/p/w500\(path)"
        if let url = URL(string: stringURL) {
            URLSession.shared.dataTask(with: url) {[weak self] (data, _, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                guard let fetchedData = data else { return }
                DispatchQueue.main.async {
                    self?.image = UIImage(data: fetchedData)
                }
            }.resume()
        }
    }
}
