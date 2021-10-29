//
//  CastViewController.swift
//  TrendMediaProject
//
//  Created by mac on 2021/10/17.
//

import UIKit
import Kingfisher

class CastViewController: UIViewController{
    
    var TMDBData : TMDBModel?
       
    var castData: [CastModel] = []
    
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
        CastTitleLabel.text = TMDBData?.original_title
        
//        let url = URL(string: tvShowInfoData?.backdropImage ?? "")
//        backgroundImgView.kf.setImage(with:url)
//        posterImgView.kf.setImage(with:url)
        
        let posterUrl = URL(string: Endpoint.tmdbPosterURL + TMDBData!.poster_path) 
        posterImgView.kf.setImage(with:posterUrl)
        
        let backgoundUrl = URL(string: Endpoint.tmdbPosterURL + TMDBData!.backdrop_path)
        backgroundImgView.kf.setImage(with:backgoundUrl)
        
        fetchCreditsData ()
        
    }
    
    @objc func locationBtnClicked(selecButton:UIButton){
        isClicked = !isClicked
        castTableView.reloadRows(at: [IndexPath(item: 0, section: 0)], with: .fade)
    }
    
    
}


extension CastViewController: UITableViewDelegate, UITableViewDataSource {
    
    func fetchCreditsData () {
        
        TMDBCreditsAPImanager.shared.fetchTrendMediaCreditsData(movie_id: TMDBData!.id) { json in
            
            for cast in json["cast"].arrayValue {
                            let name = cast["name"].stringValue
                            let character = cast["character"].stringValue
                            let profile_path = cast["profile_path"].stringValue
                            
                            let data = CastModel(name: name, character: character, profile_path: profile_path)
                            self.castData.append(data)
                            
                        }
            self.castTableView.reloadData()
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
    return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       switch section {
        case 0 :return 1
        case 1 :return castData.count
        default: return 1
        }
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
                
            let row = castData[indexPath.row]
            let url = URL(string: Endpoint.tmdbPosterURL + row.profile_path)
                        
            cell.castImageView.kf.setImage(with: url,placeholder: UIImage(systemName: "person"))
            cell.castName.text = row.name
            cell.castRole.text = row.character
                        
            return cell
        }
            
    }
    
    
}
