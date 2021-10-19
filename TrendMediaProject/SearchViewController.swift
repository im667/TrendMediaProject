//
//  SearchViewController.swift
//  TrendMediaProject
//
//  Created by mac on 2021/10/17.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
       @IBOutlet weak var SearchTableView: UITableView!
       
       @IBOutlet weak var SeachBar: UISearchBar!
    
    let searchTvShowInfo = TvShowInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SearchTableView.delegate = self
        SearchTableView.dataSource = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeBtn))

    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return searchTvShowInfo.tvShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as? SearchTableViewCell else { return UITableViewCell() }
    
        let row = searchTvShowInfo.tvShow[indexPath.row]
        
        cell.searchTitle.text = row.title
        cell.searchStory.text = row.overview
        cell.searchReleaseDate.text = row.releaseDate
        
        let url = URL(string: row.backdropImage)
        let data = try? Data(contentsOf: url!)
        cell.searchImageView.image = UIImage(data:data!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    
    @objc func closeBtn() {
        self.dismiss(animated: true, completion: nil)
    }

}
