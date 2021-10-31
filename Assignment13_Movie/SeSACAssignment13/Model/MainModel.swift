//
//  MainModel.swift
//  SeSACAssignment13
//
//  Created by 최광호 on 2021/10/28.
//

import Foundation
import Alamofire
import SwiftyJSON

struct MainModel {
    var posterPath: String
    var backDropPath: String
    var overView: String
    var title: String
    var releaseDate: String
    var voteAverage: String
    var id: String
    var media_type: String
    var genreIds: Array<Int>
}
