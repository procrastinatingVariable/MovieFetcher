//
//  ViewController.swift
//  MovieFetcher
//
//  Created by Stefan Gabriel on 18/04/2019.
//  Copyright © 2019 Stefan Gabriel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var movieFetcher = MovieFetcher()
    
    var movies: [Movie] = []
    var isLoadingMovies = false
    
    var firstBatchFetched: Bool = false {
        didSet {
            if self.firstBatchFetched == true {
                self.activityIndicator.stopAnimating()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Movies"
        self.moviesTableView.delegate = self
        self.moviesTableView.dataSource = self

        self.fetchMovies()
    }

    func fetchMovies() {
        self.isLoadingMovies = true
        self.movieFetcher.nextBatch { movies in
            self.firstBatchFetched = true
            print("Movies count: \(movies.count)")
            let insertStartIndex = self.movies.count
            print("Start index: \(insertStartIndex)")
            self.movies.append(contentsOf: movies)
            var indexPaths: [IndexPath] = []
            for index in insertStartIndex..<(insertStartIndex + movies.count) {
                indexPaths.append(IndexPath(item: index, section: 0))
            }
            self.moviesTableView.beginUpdates()
            self.moviesTableView.insertRows(at: indexPaths, with: .automatic)
            self.moviesTableView.endUpdates()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                self.isLoadingMovies = false
            })
            print("Movies fetched.")
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        cell.configure(withMovie: self.movies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && !isLoadingMovies) {
            scrollView.setContentOffset(CGPoint(x: scrollView.contentOffset.x, y: scrollView.contentOffset.y - 20), animated: false)
            self.fetchMovies()
        }
    }
}
