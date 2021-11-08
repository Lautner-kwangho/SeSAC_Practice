//
//  SearchTableViewCell.swift
//  Assignment24_Diary
//
//  Created by 최광호 on 2021/11/01.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    static let identifier = "SearchTableViewCell"
    
    @IBOutlet weak var searchTitle: UILabel!
    @IBOutlet weak var SearchDate: UILabel!
    @IBOutlet weak var searchContent: UILabel!
    @IBOutlet weak var searchImage: UIImageView!
    
    func configureCell(row: DiaryRealm) {
        searchImage.backgroundColor = .clear
        searchTitle.text = row.diaryTitle
        SearchDate.text = "\(row.diaryDate)"
        searchContent.text = row.diaryContent
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        /*
         수업 중 알아보라고 하신 거
         - awakeFromNib() : nib 파일 생성된 후 초기화 작업 진행
         - dequeueReusableCell : 재사용셀 dequeue 작업
         - willDisplay : 행을 그리기 직전에 호출됨
         - UITableViewDatasourcePrefetch : 디스플레이에 보여지는 셀 이외에 정보를 미리 호출해서 준비시켜둠
          
         (스크롤 이후에 Cell 이 화면에서 사라지면)
         - didEndDisplaying : 화면에서 Cell 이 사라질 때
         - prepareForReuse : 재사용 가능한 셀을 준비하는 메서드
         */
        searchTitle.font = UIFont().mainFont
        
        SearchDate.font = UIFont.systemFont(ofSize: 12)
        
        searchContent.font = UIFont.systemFont(ofSize: 14)
        searchContent.textColor = .systemGray2
        
        searchImage.layer.cornerRadius = searchImage.frame.size.height * 0.2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
