//
//  PostDetailViewController.swift
//  Assignment67_MemberLogin
//
//  Created by 최광호 on 2022/01/05.
//

import UIKit

class PostDetailViewController: BaseView {
    
    let tableView = UITableView()
    
    var viewModel: GetPostElement?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configure() {
        tableView.backgroundColor = .lightGray
        tableView.register(PostDetailTableCell.self, forCellReuseIdentifier: PostDetailTableCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func setupConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension PostDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.comments.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostDetailTableCell.reuseIdentifier, for: indexPath) as? PostDetailTableCell else { return UITableViewCell() }
        
        if let data = self.viewModel?.comments[indexPath.row] {
            cell.name.text = "\(data.user)"
            cell.comment.text = data.comment
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return PostDetailTableHeaderView()
    }
}
