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
            return UITableView.automaticDimension
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
            let image = UIImageView().then { imageView in
                self.viewModel.image.sendValue {
                    imageView.image = UIImage(data: $0)
                }
            }
            view.addSubview(image)
            image.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.height.equalTo(view)
                $0.width.equalTo(200)
            }
            return view
        } else {
            let view = UIView().then {
                $0.backgroundColor = .clear
            }
            
            let label = UILabel().then {
                $0.text = "Food_Pairing"
            }
            
            view.addSubview(label)
            
            label.snp.makeConstraints { make in
                make.leading.trailing.equalTo(view)
                make.height.equalTo(50)
            }
            
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == detailTableView {
            return 1
        } else if tableView == tableView {
            return self.viewModel.foodPairing.value.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == detailTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailCell.identifier, for: indexPath) as? DetailCell else {
                return UITableViewCell()
            }
            self.viewModel.title.sendValue {
                cell.title.text = $0
            }
            self.viewModel.subtitle.sendValue {
                cell.subTitle.text = $0
            }
            self.viewModel.content.sendValue {
                cell.content.text = $0
            }
    
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoCell.identifier, for: indexPath) as? InfoCell else {
                return UITableViewCell()
            }
            self.viewModel.foodPairing.sendValue {
                cell.paringLabel.text = $0[indexPath.row]
            }
            
            return cell
        }
    }
    
    
}
