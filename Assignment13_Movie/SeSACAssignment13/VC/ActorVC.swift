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
    // 1. 들어갈 공간을 만든다
    var tvData: TvShow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerSetting()
        
        let nibNam = UINib(nibName: SectionTableViewCell.identifier, bundle: nil)
        ActorTableView.register(nibNam, forCellReuseIdentifier: SectionTableViewCell.identifier)
        
        ActorTableView.delegate = self
        ActorTableView.dataSource = self
    }
    
    func headerSetting() {
        // 이렇게 작성하면 contentMode 안되는 듯? UIImage 속성이라서?
        //        actorHeaderView.backgroundColor = UIColor(patternImage: UIImage(named: "a_tale_dark_&_grimm")!)
        actorHeaderView.frame.size.height = UIScreen.main.bounds.height / 4
        miniBackgroundImage.image = UIImage(named: "a_tale_dark_&_grimm")
        miniBackgroundImage.contentMode = .scaleAspectFill
        miniPoster.backgroundColor = .label
        miniTitle.textColor = .white
        
        // 2. 어떤 걸 표현할지 정한다
        // kigfisher 오, 가져오려면 옵셔널 처리해줘야 한다 ㅎㅎ...
        if let backImage = tvData?.backdropImage, let image = tvData?.title.replacingOccurrences(of: " ", with: "_").lowercased() {
            miniBackgroundImage.kingfisher(backImage)
            miniPoster.image = UIImage(named: image)
        }
        miniTitle.text = tvData?.title
        
        // 15일차 과제(header 구현)
        
        ActorTableView.sectionHeaderHeight = 100
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: SectionTableViewCell.identifier) as? SectionTableViewCell
        cell?.sectionTextView.text = tvData?.overview
        let dimensionImage = myTitle ? "chevron.up" : "chevron.down"
        cell?.autoDimensionButton.setImage(UIImage(systemName: dimensionImage), for: .normal)
        cell?.autoDimensionButton.setTitle("", for: .normal)
        cell?.autoDimensionButton.tintColor = .black
        cell?.autoDimensionButton.addTarget(self, action: #selector(autoDimension), for: .touchUpInside)
        return cell
    }
    
    @objc func autoDimension() {
        myTitle = !myTitle
        switch myTitle {
        case true :
            ActorTableView.sectionHeaderHeight = UITableView.automaticDimension
            ActorTableView.reloadData()
        case false :
            ActorTableView.sectionHeaderHeight = 100
            ActorTableView.reloadData()
        }
    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return UIScreen.main.bounds.height / 6
//    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ActorTableViewCell.identifier, for: indexPath) as? ActorTableViewCell else {
            return UITableViewCell()
        }
        
        // 나중에 Data받으면 교체!
        cell.actorImage.image = UIImage(systemName: "face.dashed.fill")
        cell.actorName.text = "나는 배우야!"
        cell.actorRole.text = "그리고 주연이야!"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        15
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 10
    }
    
}

extension UIImageView {
    func kingfisher(_ url: String){
        let url = URL(string: url)
        self.kf.setImage(with: url)
    }
}
