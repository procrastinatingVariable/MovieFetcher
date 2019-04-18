//
//  MovieTableViewCell.swift
//  MovieFetcher
//
//  Created by Stefan Gabriel on 18/04/2019.
//  Copyright © 2019 Stefan Gabriel. All rights reserved.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(withMovie movie: Movie) {
        self.posterImage.kf.setImage(with: URL(string: Constants.POSTER_PATH + movie.poster), placeholder: UIImage(named: "placeholder"), options: [])
        self.titleLabel.text = movie.title
        self.overviewLabel.text = movie.overview
        self.voteLabel.text = String(format:"%.1f", movie.averageVote)
    }

}
