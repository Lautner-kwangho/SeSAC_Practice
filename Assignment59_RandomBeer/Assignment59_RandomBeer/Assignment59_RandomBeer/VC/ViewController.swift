//
//  ViewController.swift
//  Assignment59_RandomBeer
//
//  Created by 최광호 on 2021/12/20.
//

import UIKit
import SnapKit
import Then

class ViewController: UIViewController {

    let scrollView = UIScrollView().then {
        $0.backgroundColor = .white
    }
    
    let scrollBackgroundImage = UIImageView().then {
        $0.backgroundColor = .clear
    }
    
    let detailTableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
        $0.allowsSelection = false
        $0.separatorColor = .clear
        $0.register(DetailCell.self, forCellReuseIdentifier: DetailCell.identifier)
    }
    
    var headerView = UIImageView().then {
        $0.backgroundColor = .orange
    }
    
    let tableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
        $0.allowsSelection = false
        $0.separatorColor = .clear
        $0.register(InfoCell.self, forCellReuseIdentifier: InfoCell.identifier)
    }
    
    let buttonView = UIButton().then {
        $0.backgroundColor = .systemMint
        $0.tintColor = .white
        $0.setImage(UIImage(systemName: "repeat"), for: .normal)
    }
    let viewModel = BeerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.requestAPI(detailTableView, tableView)
        viewModel.image.sendValue {
            self.scrollBackgroundImage.image = UIImage(data: $0)
        }
        
        self.detailTableView.rowHeight = 300
        buttonView.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
        overLayout()
        scrollViewLayout()
        
        DispatchQueue.main.async {
            let blurEffect = UIBlurEffect(style: .light)
            let visualEffectView = UIVisualEffectView(effect: blurEffect)
            visualEffectView.frame = self.scrollBackgroundImage.frame
            self.scrollBackgroundImage.addSubview(visualEffectView)
        }

        
        // 여기가 문제ㅔㅔㅔ
        view.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
    }

    @objc func buttonClicked() {
        self.viewModel.requestAPI(detailTableView, tableView)
        
        viewModel.image.sendValue {
            self.scrollBackgroundImage.image = UIImage(data: $0)
        }
    }
    
    func scrollViewLayout() {
        view.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(buttonView.snp.top)
        }
        
        scrollView.addSubview(scrollBackgroundImage)
        scrollBackgroundImage.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(scrollView)
            $0.height.equalTo(500)
        }
        
        [detailTableView, tableView].forEach {
            scrollView.addSubview($0)
            $0.delegate = self
            $0.dataSource = self
            $0.snp.makeConstraints { make in
                make.width.equalToSuperview()
            }
        }
        
        detailTableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(600)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(detailTableView.snp.bottom)
            make.height.equalTo(300)
            make.bottom.equalTo(scrollView.snp.bottom)
        }
    }
    
    func overLayout() {
        
        view.addSubview(buttonView)
        
        buttonView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(100)
        }
    }
}




#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct presentable: UIViewRepresentable {
    func updateUIView(_ UIView: UIView, context: UIViewRepresentableContext<presentable>) {
    }
    func makeUIView(context: Context) -> UIView {
        ViewController().view
    }
}

@available(iOS 13.0, *)
struct ViewController_Previews: PreviewProvider {
    static var previews: some View {
        presentable()
            .previewDevice("iPhone 11")
    }
}
#endif
