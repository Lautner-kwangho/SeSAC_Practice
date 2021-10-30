//
//  ActorVC.swift
//  SeSACAssignment13
//
//  Created by 최광호 on 2021/10/16.
//

import UIKit
import Kingfisher

class ActorVC: UIViewController {

    @IBOutlet weak var ActorTableView: UITableView!
    @IBOutlet weak var actorHeaderView: UIView!
    @IBOutlet weak var miniBackgroundImage: UIImageView!
    @IBOutlet weak var miniPoster: UIImageView!
    @IBOutlet weak var miniTitle: UILabel!
    var myTitle: Bool = false
    var actorData: [ActorModel] = []
    // 1. 들어갈 공간을 만든다
    var tvData: MainModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headerSetting()
        
        ActorTableView.delegate = self
        ActorTableView.dataSource = self
        
        if let id = tvData?.id, let type = tvData?.media_type {
            callCreditData(genre: type, ID: id)
        }
    }
    
    func headerSetting() {
        // 이렇게 작성하면 contentMode 안되는 듯? UIImage 속성이라서?
        actorHeaderView.frame.size.height = UIScreen.main.bounds.height / 4
        miniBackgroundImage.backgroundColor = .gray
        miniBackgroundImage.contentMode = .scaleAspectFill
        miniPoster.backgroundColor = .label
        miniTitle.textColor = .white
        
        // 2. 어떤 걸 표현할지 정한다
        if let frontImage = tvData?.posterPath, let backImage = tvData?.backDropPath {
            miniBackgroundImage.kingfisher("https://image.tmdb.org/t/p/w500/\(backImage)")
            miniPoster.kingfisher("https://image.tmdb.org/t/p/w500/\(frontImage)")
        }
        miniTitle.text = tvData?.title
        
        // 15일차 과제(header 구현)
        ActorTableView.rowHeight = UITableView.automaticDimension
    }
    
    @objc func autoDimension() {
        myTitle = !myTitle
        ActorTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let nibNam = UINib(nibName: DimensionTableViewCell.identifier, bundle: nil)
            ActorTableView.register(nibNam, forCellReuseIdentifier: DimensionTableViewCell.identifier)
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DimensionTableViewCell.identifier) as? DimensionTableViewCell else { return UITableViewCell()}
            cell.lblDimension.text = tvData?.overView
            let dimensionImage = myTitle ? "chevron.up" : "chevron.down"
            cell.lblDimension.numberOfLines = myTitle ? 0 : 2
            cell.autoDimensionButton.setImage(UIImage(systemName: dimensionImage), for: .normal)
            cell.autoDimensionButton.setTitle("", for: .normal)
            cell.autoDimensionButton.tintColor = .black
            cell.autoDimensionButton.addTarget(self, action: #selector(autoDimension), for: .touchUpInside)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ActorTableViewCell.identifier, for: indexPath) as? ActorTableViewCell else {
                return UITableViewCell()
            }
            let actor = actorData[indexPath.row]
            // 나중에 Data받으면 교체!
            cell.actorImage.kingfisher("https://image.tmdb.org/t/p/w500/\(actor.profile_path)")
            cell.actorName.text = actor.name
            cell.actorRole.text = "그리고 주연이야!"
            
            return cell

        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 1 : self.actorData.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        } else {
            return 80
        }
    }

    
}

extension UIImageView {
    func kingfisher(_ url: String){
        kf.indicatorType = .activity
        let url = URL(string: url)
        self.kf.setImage(with: url, options: [.scaleFactor(UIScreen.main.scale), .transition(.fade(1)), .cacheOriginalImage]) { result in
            switch result {
            case .failure(let error):
                self.image = UIImage(named: "이미지준비중")
            case .success(_):
                self.kf.setImage(with: url)
            }
        }
    }
}
