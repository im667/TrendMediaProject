//
//  SearchTableViewCell.swift
//  TrendMediaProject
//
//  Created by mac on 2021/10/17.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var searchImageView: UIImageView!
    
    @IBOutlet weak var searchTitle: UILabel!
    
    
    @IBOutlet weak var searchReleaseDate: UILabel!
    
    @IBOutlet weak var searchStory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
