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
    
    // 1. 들어갈 공간을 만든다
    var tvData: TvShow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerSetting()
        
        ActorTableView.delegate = self
        ActorTableView.dataSource = self
    }
    
    func headerSetting() {
        // 이렇게 작성하면 contentMode 안되는 듯? UIImage 속성이라서?
//        actorHeaderView.frame.size.height = UIScreen.main.bounds.height / 5
//        actorHeaderView.backgroundColor = UIColor(patternImage: UIImage(named: "a_tale_dark_&_grimm")!)
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
    }
    
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
        80
    }
    
}

extension UIImageView {
    func kingfisher(_ url: String){
        let url = URL(string: url)
        self.kf.setImage(with: url)
    }
}
