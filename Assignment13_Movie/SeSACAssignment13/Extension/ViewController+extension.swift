//
//  ViewController+extension.swift
//  SeSACAssignment13
//
//  Created by 최광호 on 2021/10/28.
//

import UIKit
import SwiftyJSON

extension ViewController {
        
    func callMainData() {
        MainAPIManager.shared.fetchMainApi(frontURL: "https://api.themoviedb.org/3/trending/all/day", pageCount: pageCount) { json in
            for item in json["results"].arrayValue {
                let posterImage = item["poster_path"].stringValue
                let backDropImage = item["backdrop_path"].stringValue
                let overview = item["overview"].stringValue
//                let title = item["title"].stringValue
                let title = {
                    item["media_type"] == "movie" ? item["title"].stringValue : item["name"].stringValue
                }
                let relaseDate = {
                    item["media_type"] == "movie" ? item["release_date"].stringValue : item["first_air_date"].stringValue
                }
                let voteAverage = item["vote_average"].stringValue
                let genreIds = item["genre_ids"].arrayObject
                let id = item["id"].stringValue
                let mediaType = item["media_type"].stringValue

                let data = MainModel(posterPath: posterImage, backDropPath: backDropImage, overView: overview, title: title(), releaseDate: relaseDate(), voteAverage: voteAverage, id: id, media_type: mediaType, genreIds: (genreIds as? Array<Int>)!)
                self.mainData.append(data)
            }
            self.mainTableView.reloadData()
        }
    }
     
    func callMovieGenreData() {
        MainAPIManager.shared.fetchMainApi(frontURL: "https://api.themoviedb.org/3/genre/movie/list?api_key=\(APIKEY.tvDB)&language=en-US", pageCount: 1) { movieGenre in
            for i in movieGenre["genres"].arrayValue {
                let name = i["name"].stringValue
                let id = i["id"].intValue
                let data = GenreModel(id: id, name: name)
                self.genreMovieData.append(data)
            }
            self.mainTableView.reloadData()
        }
    }
    func callTvGenreData() {
        MainAPIManager.shared.fetchMainApi(frontURL: "https://api.themoviedb.org/3/genre/tv/list?api_key=\(APIKEY.tvDB)&language=en-US", pageCount: 1) { tvGenre in
            for i in tvGenre["genres"].arrayValue {
                let name = i["name"].stringValue
                let id = i["id"].intValue
                let data = GenreModel(id: id, name: name)
                self.genreTvData.append(data)
            }
            self.mainTableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if self.mainData.count - 1 == indexPath.row && self.mainData.count <= mainTotalCount {
                pageCount += 1
                callMainData()
                // 이건 끝 페이지가 1000이라서 누가...하루 종일 내릴까..
                print(indexPath)
            }
        }
    }
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("꿀잼이네 취소됨!!! \(indexPaths)")
    }
    
}
