//
//  MainViewController.swift
//  TrendMediaProject
//
//  Created by mac on 2021/10/17.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tvShowInfo = TvShowInfo()
    
    @IBOutlet weak var mainTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        self.navigationItem.title = "main"
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvShowInfo.tvShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell else { return UITableViewCell()}
        
        let row = tvShowInfo.tvShow[indexPath.row]
        
        let url = URL(string: row.backdropImage)
        let data = try? Data(contentsOf: url!)
        cell.mainImageView.image = UIImage(data: data!)
        cell.mainGenre.text = row.genre
        cell.mainTitle.text = row.title
        cell.mainRate.text = "\(row.rate)"
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        300
    }

}
