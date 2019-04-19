//
//  Movie.swift
//  MovieFetcher
//
//  Created by Stefan Gabriel on 18/04/2019.
//  Copyright © 2019 Stefan Gabriel. All rights reserved.
//

import Foundation

struct Movie {


    var title: String
    var overview: String
    var poster: String
    var averageVote: Double
    
    
    enum CodingKeys: String, CodingKey {
        case title =       "title"
        case overview =    "overview"
        case poster =      "poster_path"
        case averageVote = "vote_average"
    }
    
    init(title: String, overview: String, poster: String, averageVote: Double) {
        self.title = title
        self.overview = overview
        self.poster = poster
        self.averageVote = averageVote
    }
    
}

extension Movie: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try values.decode(String.self, forKey: .title)
        self.overview = try values.decode(String.self, forKey: .overview)
        self.poster = try values.decode(String.self, forKey: .poster)
        self.averageVote = try values.decode(Double.self, forKey: .averageVote)
    }
}

