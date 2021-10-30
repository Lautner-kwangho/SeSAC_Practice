//
//  ViewController.swift
//  SeSACAssignment13
//
//  Created by 최광호 on 2021/10/16.
//

import UIKit
import SwiftUI
import SwiftyJSON
import Kingfisher

class ViewController: UIViewController {
    var mainTotalCount = 1000
    var pageCount = 1
    var mainData: [MainModel] = []
    var genreData: [GenreModel] = []
    
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var btnFilm: UIButton!
    @IBOutlet weak var btnTv: UIButton!
    @IBOutlet weak var btnBook: UIButton!
    let tvShowInfomation = TvShowInfomation().tvShow
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // NavigationItem 설정
        naviSetting()
        // HeaderView 설정
        HeaderView()
        btnFilm.setting("flim", color: .green)
        btnFilm.addTarget(self, action: #selector(goToDaily), for: .touchUpInside)
        btnTv.setting("tv", color: .orange)
        btnBook.setting("book", color: .systemBlue)
        btnBook.addTarget(self, action: #selector(goToBook), for: .touchUpInside)

        
        // Delegate, DataSource 설정
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.prefetchDataSource = self
        // 사용시, viewDidLoad에 작성하며, rowforHeight는 override하지 않는다 추가로 포스터와 같은 형식은 세로 값을 기준으로 사용되는 듯하다!
//        mainTableView.estimatedRowHeight = UIScreen.main.bounds.height / 4
//        mainTableView.rowHeight = UITableView.automaticDimension
        
        // TVDB - json
        callMainData()
        callGenreData()
    }
    
    func naviSetting() {
        navigationItem.title = "TREND Media"
        
        let listButton = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .plain, target: self, action: nil)
        let goToMapButton = UIBarButtonItem(image: UIImage(systemName: "map.circle"), style: .plain, target: self, action: #selector(goToMap))
        
        let leftItems = [listButton, goToMapButton]
        navigationItem.leftBarButtonItems = leftItems
        
        for leftItem in 0..<leftItems.count {
            navigationItem.leftBarButtonItems?[leftItem].tintColor = .black
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchVC))
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    @objc func goToDaily() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: DailyOfficeVC.identifier) as! DailyOfficeVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func goToMap() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: MapVC.identifier) as! MapVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func searchVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchVC")
        let nav = UINavigationController(rootViewController: vc)
        nav.modalTransitionStyle = .crossDissolve
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
    func HeaderView() {
        headerView.backgroundColor = .systemGray5
        let secondVL = headerView.viewWithTag(3)
        secondVL?.layer.cornerRadius = 10
        secondVL?.layer.shadowColor = UIColor.black.cgColor
        secondVL?.layer.shadowOffset = CGSize(width: 5, height: 5)
        secondVL?.layer.shadowOpacity = 0.3
    }
    
    // push만 구현함 pop은 알아서 되니까 일단 냅둠(추후에 더 수정할 수 있음 수정하기로)
    @objc func goToBook() {
        let popBookVC = self.storyboard?.instantiateViewController(withIdentifier: "BookCollectionVC") as! BookCollectionVC
        self.navigationController?.pushViewController(popBookVC, animated: true)
        // 3. 데이터 연결해준다
//        let row = tvShowInfomation[indexPath.row]
//        popVC.tvData = row
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell else {
            return UITableViewCell()
        }
        
        let md = mainData[indexPath.row]
        
        
//        for genreDatum in genreData {
//            for genre in md.genreIds {
//                print("\(genreDatum)")
//            }
//        }
//        for genre in md.genreIds {
//            for (datum) in genreData {
//                print(datum.name)
//            }
//        }
        // ㅏ아아 바보다 GenreModel dic형태인줄; 내일 다시 해야겠다..
        cell.trendGenre.text = "\(md.genreIds)"
        cell.trendRelease.text = md.releaseDate
        cell.imgPoster.kingfisher("https://image.tmdb.org/t/p/w500/\(md.posterPath)")
        cell.trendRate.text = "\(round(Double(md.voteAverage)!))"
        cell.trendName.text = md.title
        cell.trendOverview.text = md.overView
                
        cell.linkTvShow.tag = indexPath.row
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 1.3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let popVC = self.storyboard?.instantiateViewController(withIdentifier: "ActorVC") as! ActorVC
        // 3. 데이터 연결해준다
        let row = mainData[indexPath.row]
        popVC.tvData = row
        
        self.navigationController?.pushViewController(popVC, animated: true)
    }
    
    @IBAction func linkedPresent(_ sender: UIButton) {
        let sb = self.storyboard?.instantiateViewController(withIdentifier: LinkedVC.identifier) as! LinkedVC
        let navi = UINavigationController(rootViewController: sb)
        
        let row = TvShowInfomation().tvShow[sender.tag].title
        sb.title = "\(row)"
        self.present(navi, animated: true, completion: nil)
    }
    
}




// tableView extension VC에서는 override해서 추가 수정
extension UIViewController : UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}

extension UIButton {
    func setting(_ ImageName: String, color: UIColor) {
        self.setTitle("", for: .normal)
        self.setImage(UIImage(named: ImageName), for: .normal)
        self.tintColor = color
    }
}
