//
//  CastViewController.swift
//  TrendMediaProject
//
//  Created by mac on 2021/10/17.
//

import UIKit

class CastViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    var tvShowInfoData : TvShow?
    
   
    
    
    
    
    static let identifier = "CastViewController"
    
    
    @IBOutlet weak var castTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
    
        navigationItem.title = "출연/제작"
        self.navigationController?.navigationBar.topItem?.title = "back"
        
        castTableView.delegate = self
        castTableView.dataSource = self
        castTableView.estimatedRowHeight = 150
        castTableView.rowHeight = UITableView.automaticDimension
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        300
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = castTableView.dequeueReusableCell(withIdentifier: "CastTableViewCell") as? CastTableViewCell else {
            return UITableViewCell()
        }
        
        cell.castImageView.image = UIImage(systemName: "person")
        cell.castName.text = "example-name"
        cell.castRole.text = "example-role"
        
        
        return cell
    }

    
    
}
