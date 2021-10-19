//
//  BookCollectionViewCell.swift
//  TrendMediaProject
//
//  Created by mac on 2021/10/20.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BookCollectionViewCell"

    @IBOutlet weak var bookCollectionImageView: UIImageView!
    
    @IBOutlet weak var bookCollectionTitleLabel: UILabel!
    
    @IBOutlet weak var bookCollectionRateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
