//
//  PostMainPageViewController.swift
//  Assignment67_MemberLogin
//
//  Created by 최광호 on 2022/01/04.
//

import UIKit

class PostMainPageViewController: BaseView {
    
    let tableView = UITableView().then {
        $0.backgroundColor = .systemGray4
    }
    let viewModel = PostMainPageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configure() {
        self.title = viewModel.title
        
        let nibName = UINib(nibName: PostTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: PostTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel.getPost(self) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func setupConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

}

extension PostMainPageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableViewNumberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.reuseIdentifier, for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
        
        cell.cellConfigure(cell, indexPath)
        
        viewModel.tableData.receiveData { data in
            let data = data[indexPath.row]
            cell.name.text = data.user.username
            cell.content.text = data.text
            cell.date.text = self.viewModel.dateFormatter(at: indexPath)
            cell.commentButton.setTitle(self.viewModel.commentCount(at: indexPath), for: .normal)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 4
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PostDetailViewController()
        viewModel.tableData.receiveData { data in
            let data = data[indexPath.row]
            vc.viewModel = data
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
