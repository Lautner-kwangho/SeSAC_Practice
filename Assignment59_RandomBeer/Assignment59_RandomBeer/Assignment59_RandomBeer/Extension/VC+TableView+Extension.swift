//
//  VC+TableView+Extension.swift
//  Assignment59_RandomBeer
//
//  Created by 최광호 on 2021/12/20.
//

import UIKit
import SwiftUI

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == detailTableView {
            return 200
        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == detailTableView {
            return 400
        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == detailTableView {
            let view = UIView()
            let image = UIImageView().then {
                $0.image = UIImage(systemName: "heart")
            }
            view.addSubview(image)
            image.snp.makeConstraints {
                $0.width.height.equalTo(view)
            }
            return view
        } else {
            let view = UIView().then {
                $0.backgroundColor = .orange
            }
            
            let label = UILabel().then {
                $0.text = "eeee"
            }
            
            view.addSubview(label)
            
            label.snp.makeConstraints { make in
                make.leading.trailing.equalTo(view)
                make.height.equalTo(40)
            }
            
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == detailTableView {
            return 1
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == detailTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailCell.identifier, for: indexPath) as? DetailCell else {
                return UITableViewCell()
            }
            cell.title.text = "타이틀 들어가는 곳"
            cell.subTitle.text = "서브타이틀 들어가는 곳"
            cell.content.text = "컨텐츠 들어가는 곳"
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoCell.identifier, for: indexPath) as? InfoCell else {
                return UITableViewCell()
            }
            
            cell.paringLabel.text = "eeee"
            
            return cell
        }
    }
    
    
}
