//
//  HomeFeedTableViewCell.swift
//  FakeInstagram
//
//  Created by Türkay on 20.02.2022.
//

import UIKit

class HomeFeedTableViewCell: UITableViewCell {

    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
