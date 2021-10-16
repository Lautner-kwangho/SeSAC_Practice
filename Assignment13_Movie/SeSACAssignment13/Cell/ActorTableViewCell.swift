//
//  ActorTableViewCell.swift
//  SeSACAssignment13
//
//  Created by 최광호 on 2021/10/16.
//

import UIKit

class ActorTableViewCell: UITableViewCell {

    static let identifier = "ActorTableViewCell"

    @IBOutlet weak var actorImage: UIImageView!
    @IBOutlet weak var actorName: UILabel!
    @IBOutlet weak var actorRole: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        actorImage.image = UIImage(systemName: "face.dashed.fill")
        actorImage.layer.cornerRadius = 10
        actorName.text = "나는 배우!"
        actorName.fontSetting(size: 15)
        actorRole.text = "인생에서 주연은 나!"
        actorRole.grayFontSetting()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
