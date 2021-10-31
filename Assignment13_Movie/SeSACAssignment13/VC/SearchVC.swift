//
//  SearchVC.swift
//  SeSACAssignment13
//
//  Created by 최광호 on 2021/10/16.
//

import UIKit
import Alamofire
import SwiftyJSON

class SearchVC: UIViewController, UITableViewDataSourcePrefetching {
    
    //셀이 화면에 보이기 전에 필요한 리소스를 미리 다운 받는 기능
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {
            if movieData.count - 1 == indexPath.row && movieData.count < totalCount {
                startPage += 10
                fetchMovieData(query: searchBar.text!)
                print("prefetch: \(indexPath)")
            }
        }

    }
    //취소
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("취소: \(indexPaths)")
    }

    @IBOutlet weak var SearchTableView: UITableView!
    var movieData: [MovieModel] = []
    var startPage = 1
    var totalCount = 2138
    
    let searchBar = { () -> UISearchBar in
        let search = UISearchBar()
        search.placeholder = "어떤 영화 찾아?"
        return search
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // NavigationBar
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closedClicked))
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        self.navigationItem.titleView = searchBar
        
        // TableView 입력
        SearchTableView.delegate = self
        SearchTableView.dataSource = self
        searchBar.delegate = self
        // 통신
//        fetchMovieData()
        SearchTableView.prefetchDataSource = self
    }
    // 네이버 영화 네트워크 통신
    func fetchMovieData(query: String) {
        
        // 네이버 영화 API 호출해서 debug 해보기
        if let query = query.addingPercentEncoding(withAllowedCharacters: .afURLQueryAllowed) {
            let url = "https://openapi.naver.com/v1/search/movie.json?query=\(query)&display=10&start=\(startPage)"
            
            let header: HTTPHeaders = [
                "X-Naver-Client-Id" : APIKEY.clientNaverID,
                "X-Naver-Client-Secret" : APIKEY.clientNaverPassWord
            ]
            
            AF.request(url, method: .get, headers: header).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    // totalCount = json["total임의로"].intValue
                    for item in json["items"].arrayValue {
                        let value = item["title"].stringValue.replacingOccurrences(of: "</b>", with: "").replacingOccurrences(of: "<b>", with: "")
                        let image = item["image"].stringValue
                        let link = item["link"].stringValue
                        let userRating = item["userRating"].stringValue
                        let sub = item["subtitle"].stringValue
                        
                        let data = MovieModel(titleData: value, imageData: image, linkData: link, userRatingData: userRating, subtitle: sub)
                        
                        self.movieData.append(data)
                    }
                    let total = json["total"].intValue
                    self.totalCount = total
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
        /*
         if let url = URL(string: row.imageData {
            cell.img.kr.setImage(url:url)
         } else {
            cell.img.image = UIImage(systemName: "Star")
         }
         */
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

extension SearchVC: UISearchBarDelegate {
    // 검색 버튼 (키보드 리턴키) 눌렀을 때 실행
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        if let text = searchBar.text {
            movieData.removeAll()
            startPage = 1
            fetchMovieData(query: text)
            //progress 구현
        }
    }
    // 취소 버튼 눌렀을 때
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        movieData.removeAll()
        SearchTableView.reloadData()
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
    }
    // 서치바에 커서가 깜빡이기 시작할 때
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print(#function)
        searchBar.setShowsCancelButton(true, animated: true)
    }
}
