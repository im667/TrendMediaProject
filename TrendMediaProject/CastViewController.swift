//
//  CastViewController.swift
//  TrendMediaProject
//
//  Created by mac on 2021/10/17.
//

import UIKit
import Kingfisher

class CastViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var tvShowInfoData : TvShow?
    var isClicked:Bool = false
    
    @IBOutlet weak var backgroundImgView: UIImageView!
    
    @IBOutlet weak var posterImgView: UIImageView!
    
    @IBOutlet weak var CastTitleLabel: UILabel!
    
    @IBOutlet weak var castTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationItem.title = "Cast"
        
        castTableView.delegate = self
        castTableView.dataSource = self
        castTableView.estimatedRowHeight = 150
        castTableView.rowHeight = UITableView.automaticDimension
        
        CastTitleLabel.textColor = .green
        CastTitleLabel.text = tvShowInfoData?.title
        
        let url = URL(string: tvShowInfoData?.backdropImage ?? "")
        backgroundImgView.kf.setImage(with:url)
        posterImgView.kf.setImage(with:url)
        
    }
    
    @objc func locationBtnClicked(selecButton:UIButton){
        isClicked = !isClicked
        castTableView.reloadRows(at: [IndexPath(item: 0, section: 0)], with: .fade)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0{
            guard let LocationCell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.identifier, for: indexPath) as? LocationTableViewCell else {
                return UITableViewCell()
            }
            
            let line = isClicked ? 0 : 3
            LocationCell.overViewLabel.text = tvShowInfoData?.overview
            LocationCell.overViewLabel.numberOfLines = line
            
            let locationBtnImg = isClicked ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chvron.down")
            LocationCell.locationBtn.setImage(locationBtnImg, for: .normal)
            LocationCell.locationBtn.addTarget(self, action: #selector(locationBtnClicked), for: .touchUpInside)
            return LocationCell
            
        } else {
            
            guard let cell = castTableView.dequeueReusableCell(withIdentifier: "CastTableViewCell") as? CastTableViewCell else {
                return UITableViewCell()
            }
                
            cell.castImageView.image = UIImage(systemName: "person")
            cell.castName.text = "example-name"
            cell.castRole.text = "example-role"
                
            return cell
        }
            
    }

   
    
}

