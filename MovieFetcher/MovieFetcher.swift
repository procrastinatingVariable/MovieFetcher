//
//  MovieFetcher.swift
//  MovieFetcher
//
//  Created by Stefan Gabriel on 18/04/2019.
//  Copyright © 2019 Stefan Gabriel. All rights reserved.
//

import Foundation
import Alamofire

class MovieFetcher {
    
    var pageIndex: Int = 1
    
    func nextBatch(completion: @escaping ([Movie]) -> Void) {
        Alamofire.request(Constants.MOVIES_LIST_URL + "&page=\(self.pageIndex)", method: .get, parameters: [:], encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { response in
            var movies: [Movie] = []
            switch response.result {
            case .success(let data):
                guard let json = data as? [String : Any] else { completion(movies); return }
                guard let results = json["results"] as? [[String: Any]] else { completion(movies); return }
                for movieDict in results {
                    let movieTitle = movieDict["title"] as? String ?? "Unknown title"
                    let movieOverview = movieDict["overview"] as? String ?? "Unknown overview"
                    let moviePoster = movieDict["poster_path"] as? String ?? ""
                    let movieAverageVote = movieDict["vote_average"] as? Double ?? 0.0
                    let movie = Movie(title: movieTitle, overview: movieOverview, poster: moviePoster, averageVote: movieAverageVote)
                    movies.append(movie)
                }
            case .failure(let error):
                print(error)
            }
            print(response)
            completion(movies)
            self.pageIndex += 1
        })
    }
}
