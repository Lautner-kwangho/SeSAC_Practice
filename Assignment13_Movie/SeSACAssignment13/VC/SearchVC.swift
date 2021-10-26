//
//  SearchVC.swift
//  SeSACAssignment13
//
//  Created by 최광호 on 2021/10/16.
//

import UIKit
import Alamofire
import SwiftyJSON

class SearchVC: UIViewController {

    @IBOutlet weak var SearchTableView: UITableView!
    var movieData: [MovieModel] = []
    
    let searchBar = { () -> UISearchBar in
        let search = UISearchBar()
        search.placeholder = "어떤 영화 찾아?"
        return search
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // NavigationBar
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closedClicked))
        self.navigationItem.titleView = searchBar()
        
        // TableView 입력
        SearchTableView.delegate = self
        SearchTableView.dataSource = self
        
        // 통신
        fetchMovieData()
    }
    // 네이버 영화 네트워크 통신
    func fetchMovieData() {
        
        // 네이버 영화 API 호출해서 debug 해보기
        if let query = "스파이더맨".addingPercentEncoding(withAllowedCharacters: .afURLQueryAllowed) {
            let url = "https://openapi.naver.com/v1/search/movie.json?query=\(query)&display=15&start=16"
            
            let header: HTTPHeaders = [
                "X-Naver-Client-Id" : APIKEY.clientNaverID,
                "X-Naver-Client-Secret" : APIKEY.clientNaverPassWord
            ]
            
            AF.request(url, method: .get, headers: header).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("JSON: \(json)")
                    
                    for item in json["items"].arrayValue {
                        let value = item["title"].stringValue.replacingOccurrences(of: "</b>", with: "").replacingOccurrences(of: "<b>", with: "")
                        let image = item["image"].stringValue
                        let link = item["link"].stringValue
                        let userRating = item["userRating"].stringValue
                        let sub = item["subtitle"].stringValue
                        
                        let data = MovieModel(titleData: value, imageData: image, linkData: link, userRatingData: userRating, subtitle: sub)
                        
                        self.movieData.append(data)
                    }
                    print(self.movieData)
                    
                    // 중요!!
                    self.SearchTableView.reloadData()
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
        
    }
    
    @objc func closedClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        let row = movieData[indexPath.row]
        
        // 나중에 Data받으면 교체!
        cell.imgPoster.kingfisher("\(row.imageData)")
        cell.posterName.text = row.titleData
        cell.posterRelase.text = row.subtitle
        cell.posterOverview.text = row.userRatingData
        
        print(row.imageData)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 8
    }
    
}
