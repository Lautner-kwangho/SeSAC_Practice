//
//  ActorVC.swift
//  SeSACAssignment13
//
//  Created by 최광호 on 2021/10/16.
//

import UIKit

class ActorVC: UIViewController {

    @IBOutlet weak var ActorTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ActorTableView.delegate = self
        ActorTableView.dataSource = self
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
