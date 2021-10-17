//
//  MainTableViewCell.swift
//  TrendMediaProject
//
//  Created by mac on 2021/10/17.
//

import UIKit




class MainTableViewCell: UITableViewCell {
    
    static let identifier = "mainTableViewCell"

    @IBOutlet weak var mainGenre: UILabel!
    
    
    @IBOutlet weak var mainTitle: UILabel!
    
    @IBOutlet weak var mainRate: UILabel!
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
