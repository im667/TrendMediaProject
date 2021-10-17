//
//  CastTableViewCell.swift
//  TrendMediaProject
//
//  Created by mac on 2021/10/17.
//

import UIKit

class CastTableViewCell: UITableViewCell {
    
    @IBOutlet weak var castImageView: UIImageView!
    
    @IBOutlet weak var castName: UILabel!
    
    @IBOutlet weak var castRole: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
