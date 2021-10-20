//
//  LocationTableViewCell.swift
//  TrendMediaProject
//
//  Created by mac on 2021/10/20.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    
    static let identifier = "LocationTableViewCell"
    
    @IBOutlet weak var overViewLabel: UILabel!
    
    
    @IBOutlet weak var locationBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        locationBtn.setImage(UIImage(systemName: "chevron.down.circle"), for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
