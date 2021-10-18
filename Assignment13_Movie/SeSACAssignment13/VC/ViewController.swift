//
//  ViewController.swift
//  SeSACAssignment13
//
//  Created by 최광호 on 2021/10/16.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

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
        btnTv.setting("tv", color: .orange)
        btnBook.setting("book", color: .systemBlue)

        
        // Delegate, DataSource 설정
        mainTableView.delegate = self
        mainTableView.dataSource = self
        // 사용시, viewDidLoad에 작성하며, rowforHeight는 override하지 않는다 추가로 포스터와 같은 형식은 세로 값을 기준으로 사용되는 듯하다!
        mainTableView.estimatedRowHeight = UIScreen.main.bounds.height / 4
        mainTableView.rowHeight = UITableView.automaticDimension
    }
    
    
    func naviSetting() {
        navigationItem.title = "TREND Media"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem()
        navigationItem.leftBarButtonItem?.image = UIImage(systemName: "list.dash")
        navigationItem.leftBarButtonItem?.tintColor = .systemGray3
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchVC))
        navigationItem.rightBarButtonItem?.tintColor = .black
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
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell else {
            return UITableViewCell()
        }
        
        let tv = tvShowInfomation[indexPath.row]
        cell.lblName.text = tv.title
        cell.lblTag.text = tv.genre
        cell.imgPoster.image = UIImage(named: "\(tv.title.replacingOccurrences(of: " ", with: "_").lowercased())")
        cell.posterRate.text = "\(tv.rate)"
        cell.posterName.text = tv.title
        cell.posterRelase.text = tv.releaseDate
                
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvShowInfomation.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let popVC = self.storyboard?.instantiateViewController(withIdentifier: "ActorVC") as! ActorVC
        // 3. 데이터 연결해준다
        let row = tvShowInfomation[indexPath.row]
        popVC.tvData = row
        
        self.navigationController?.pushViewController(popVC, animated: true)
    }
    
    @IBAction func linkedPresent(_ sender: UIButton) {
        let sb = self.storyboard?.instantiateViewController(withIdentifier: LinkedVC.identifier) as! LinkedVC
        let navi = UINavigationController(rootViewController: sb)
        
        // 에효...
        var titleArray: [String] = []
        let na: Int = tvShowInfomation.count
        for i in 0..<na {
            let vell = TvShowInfomation().tvShow[i].title
            titleArray.append(vell)
        }
        
        sb.linkedTitle = "\(titleArray)"
        
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
