//
//  ReviewTableViewCell.swift
//  Sahara
//
//  Created by Antonio Torres-Ruiz on 6/3/21.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    
    @IBOutlet weak var userRating: CosmosView!
    @IBOutlet weak var productReview: UILabel!
    @IBOutlet weak var username: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
