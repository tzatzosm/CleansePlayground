//
//  TopStoriesTableViewCell.swift
//  CleansePlayground
//
//  Created by Tzatzo, Marsel, Vodafone Greece on 12/02/2020.
//  Copyright © 2020 Tzatzo, Marsel, Vodafone Greece. All rights reserved.
//

import UIKit

class TopStoriesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var story: HNStory? {
        didSet {
            guard let story = story else { return }
            updateUI(story: story)
        }
    }
     
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

fileprivate extension TopStoriesTableViewCell {
    
    func updateUI(story: HNStory) {
        titleLabel.text = story.title
        subtitleLabel.text = "by \(story.by)"
        dateLabel.text = ""
    }
    
    func resetCell() {
        titleLabel.text = "-"
        subtitleLabel.text = "-"
        dateLabel.text = "-"
    }
    
}
