//
//  SearchResultsTableViewCell.swift
//  Sahara
//
//  Created by Antonio Torres-Ruiz on 6/2/21.
//

import UIKit

class SearchResultsTableViewCell: UITableViewCell {

    @IBOutlet weak var productLB: UILabel!
    @IBOutlet weak var priceLB: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
