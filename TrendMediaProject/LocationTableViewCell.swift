//
//  LocationTableViewCell.swift
//  TrendMediaProject
//
//  Created by mac on 2021/10/20.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var overViewTextView: UITextView!
    
    @IBOutlet weak var LocationButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        LocationButton.setImage(UIImage(systemName: "chevron.down.circle"), for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
