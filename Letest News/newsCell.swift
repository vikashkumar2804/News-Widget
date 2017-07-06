//
//  newsCell.swift
//  News
//
//  Created by Vikash on 05/07/17.
//  Copyright © 2017 Vikash. All rights reserved.
//

import UIKit

class newsCell: UITableViewCell {

    @IBOutlet var newsImage: UIImageView!
    @IBOutlet var source: UILabel!
    @IBOutlet var title: UILabel!
    @IBOutlet var publishedAt: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        newsImage.layer.cornerRadius = 4
        newsImage.layer.masksToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
