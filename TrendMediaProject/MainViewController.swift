//
//  MainViewController.swift
//  TrendMediaProject
//
//  Created by mac on 2021/10/17.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tvShowInfo = TvShowInfo()
    
    var indexPathRow = 0
    
    
    @IBOutlet weak var mainTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.estimatedRowHeight = 300
        mainTableView.rowHeight = UITableView.automaticDimension
        self.title = "main"
        
        let backBarButtonItem = UIBarButtonItem(title: "뒤뒤", style: .plain, target: self, action: #selector(IsClickedBackBtn))
        
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
 
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 1. sb
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        // 2. vc
        guard let vc = sb.instantiateViewController(withIdentifier: "CastViewController") as? CastViewController else { return }
        
        
        // pass data
        let row = tvShowInfo.tvShow[indexPath.row]
        vc.tvShowInfoData = row
        
        // 3.push
        self.navigationController?.pushViewController(vc, animated: true)
        
        
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

    @objc func IsClickedBackBtn() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func onBackBarButtonClicked () {
            navigationController?.popViewController(animated: true)
        }
    
    
    @IBAction func SearchBtn(_ sender: UIBarButtonItem) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = sb.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true, completion: nil)
        
        
        print("SearchClicked")
    }
    
}
