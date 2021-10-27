//
//  SearchViewController.swift
//  TrendMediaProject
//
//  Created by mac on 2021/10/17.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher


//페이지네이션 2: UITableViewDataSourcePrefetching 추가
class SearchViewController: UIViewController, UITableViewDataSourcePrefetching {
    
    //페이지네이션 4: 셀이 화면에 보이기 전에 필요한 리소스를 미리 다운 받는 기능
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {
            if movieData.count - 1 == indexPath.row && movieData.count < totalCount {
                startPage += 10
                fetchMovieData()
                print("prefetch:\(indexPath)")
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("취소:\(indexPaths)")
    }
    
    var movieData:[MovieModel] = []
    
       @IBOutlet weak var SearchTableView: UITableView!
       @IBOutlet weak var SeachBar: UISearchBar!
    
    //페이지네이션 1: 스타트페이지 설정
    var startPage = 1
    
    //페이지네이션 5: 카운트 설정
    var totalCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SearchTableView.delegate = self
        SearchTableView.dataSource = self

        //페이지 네이션 3: 프로토콜 연결
        SearchTableView.prefetchDataSource = self
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeBtn))
       
        fetchMovieData()
    }
    
    @objc func closeBtn() {
        self.dismiss(animated: true, completion: nil)
    }
    
}





extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func fetchMovieData() {
        
       if let query = "어벤져스".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
        let url = "https://openapi.naver.com/v1/search/movie.json?query=\(query)&display=10&start=\(startPage)"
        let headers:HTTPHeaders = [
            "X-Naver-Client-Id":"pCD7fvTZfdSST7e7Uf5r",
            "X-Naver-Client-Secret":"9Fy1tKyG9O"
        ]
        
        AF.request(url, method: .get, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                self.totalCount = json["total"].intValue
                
                for item in json["items"].arrayValue {
                    
                    let value = item["title"].stringValue.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                    
                    let image = item["image"].stringValue
                    let link = item["link"].stringValue
                    let userRating = item["userRating"].stringValue
                    let sub = item["subtitle"].stringValue
                    
                    let data = MovieModel(titleData: value, imageData: image, linkData: link, userRatingData: userRating, subtitle: sub)
                    
                    self.movieData.append(data)
                    
                }
                //중요!
                self.SearchTableView.reloadData()
            
            case .failure(let error):
                print(error)
                }
            }

        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieData.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return movieData.count
    }
    
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier) as?
                SearchTableViewCell else {return UITableViewCell()}
    
        let row = movieData[indexPath.row]
        
        cell.searchTitle.text = row.titleData
        cell.searchStory.text = row.subtitle
        cell.searchReleaseDate.text = row.userRatingData

        if let url = URL(string: row.imageData){
        cell.searchImageView.kf.setImage(with: url)
        } else {
            cell.searchImageView.image = UIImage(systemName: "person")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
        
    }

    

    


