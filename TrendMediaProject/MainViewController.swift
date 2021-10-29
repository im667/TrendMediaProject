//
//  MainViewController.swift
//  TrendMediaProject
//
//  Created by mac on 2021/10/17.
//

import UIKit
import Kingfisher

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    let tvShowInfo = TvShowInfo()
    
    var indexPathRow = 0
    
    var tmdbData: [TMDBModel] = []
    var pageNum = 1
    
    let totalPageCount = 1000
    
    @IBOutlet weak var mainTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.estimatedRowHeight = 300
        mainTableView.rowHeight = UITableView.automaticDimension
        
        self.title = "main"
        
        let SearchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(SearchButton(_:)))
        
        let MapButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(mapViewButton(_:)))
        
        let backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(IsClickedBackBtn))
        
        
        
        self.navigationItem.rightBarButtonItems = [MapButton,SearchButton]
        
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        fetchTMDBData()
    }
    
    
    
    func fetchTMDBData() {
            
            TMDBApiManager.shared.fetchData(page: pageNum) { json in
                       
                       for db in json["results"].arrayValue {
                           let title = db["original_title"].stringValue
                           let rate = db["vote_average"].doubleValue
                           let posterImage = db["poster_path"].stringValue
                           
                           let backdropImage = db["backdrop_path"].stringValue
                           let id = db["id"].intValue
                           let overview = db["overview"].stringValue
                           
                           let data = TMDBModel(original_title: title, vote_average: rate, poster_path: posterImage, backdrop_path:backdropImage ,id: id, overview:overview)
                           self.tmdbData.append(data)
                           
                       }
                       
                       self.mainTableView.reloadData()
                       
                   }
                   

    }
    
 
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
      
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
      
        guard let vc = sb.instantiateViewController(withIdentifier: "CastViewController") as? CastViewController else { return }
        
        
      
        let row = tmdbData[indexPath.row]
        vc.TMDBData=row
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tmdbData.count
    }
    
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
            
            for indexPath in indexPaths {
                if tmdbData.count - 1 == indexPath.row && tmdbData.count < totalPageCount { // 마지막에 도달하면
                    pageNum += 1
                    fetchTMDBData()
                    print("prefetch: \(indexPath)")
                }
                
            }
            
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell else { return UITableViewCell()}
        
        let row = tmdbData[indexPath.row]
        
        cell.mainTitle.text = row.original_title
    
       cell.mainRate.text = "\(row.vote_average)"

        let url = URL(string: Endpoint.tmdbPosterURL + row.poster_path)

        cell.mainImageView.kf.setImage(with: url)
        
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
    
    
    @objc func SearchButton(_ sender: UIBarButtonItem) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = sb.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true, completion: nil)
        
        
        print("SearchClicked")
        
    }
  
    @objc func mapViewButton(_ sender:UIBarButtonItem){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: CinemaViewController.identifier) as! CinemaViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func goToBookPage(_ sender: Any) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        guard let vc = sb.instantiateViewController(withIdentifier: "BookViewController") as? BookViewController else {return}
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
