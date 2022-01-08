//
//  PostDetailViewController.swift
//  Assignment67_MemberLogin
//
//  Created by 최광호 on 2022/01/05.
//

import UIKit

class PostDetailViewController: BaseView {
    
    let tableView = UITableView()
    let textField = UITextField().then {
        $0.setLeftPaddingPoints()
        $0.setRightPaddingPoints()
        $0.setBorderLine()
    }
    let commentInputButton = UIButton().then {
        $0.setImage(UIImage(systemName: "arrow.up"), for: .normal)
        $0.isHidden = true
    }
    
    var viewModel: GetPostElement?
    var postViewModel = PostDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        postViewModel.getComment(viewModel, tableView)
    }
    
    override func configure() {
        tableView.register(PostDetailTableCell.self, forCellReuseIdentifier: PostDetailTableCell.reuseIdentifier)
        tableView.register(PostDetailTableHeaderView.self, forCellReuseIdentifier: PostDetailTableHeaderView.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        textField.placeholder = postViewModel.textPlaceholder
        textField.addTarget(self, action: #selector(sendData), for: .editingChanged)
        commentInputButton.addTarget(self, action: #selector(commentInputButtonClicked), for: .touchUpInside)
    }
    
    override func setupConstraints() {
        view.addSubview(textField)
        textField.snp.makeConstraints {
            $0.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(50)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(textField.snp.top)
        }
        
        view.addSubview(commentInputButton)
        commentInputButton.snp.makeConstraints {
            $0.bottom.equalTo(textField.snp.top)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(44)
        }
        
        let editButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .done, target: self, action: #selector(editButtonClicked))
        self.navigationItem.rightBarButtonItem = editButton
    }
    
    @objc func editButtonClicked() {
        postViewModel.editAction(self, self.viewModel)
    }
    
    @objc func sendData() {
        postViewModel.sendData(self.textField, self.commentInputButton)
    }
    
    @objc func commentInputButtonClicked() {
        postViewModel.commentInput(self, self.viewModel, self.textField) {
            self.postViewModel.getComment(self.viewModel, self.tableView)
            self.commentInputButton.isHidden = true
        }
    }
    
    @objc func commentEditButtonClicked(_ sender: UIButton) {
        postViewModel.commentEdit(self, self.viewModel, sender.tag, tableView) {
            self.postViewModel.getComment(self.viewModel, self.tableView)
        }
    }
}

extension PostDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return postViewModel.tableViewNumberOfRows
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostDetailTableHeaderView.reuseIdentifier, for: indexPath) as? PostDetailTableHeaderView else {
                return UITableViewCell()
            }
            cell.cellConfigure(cell, indexPath)
            if let data = self.viewModel {
                cell.name.text = data.user.username
                cell.comment.text = data.text
                cell.commentCount.text = "\(postViewModel.commentTableData.valueData.count)개 댓글"
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostDetailTableCell.reuseIdentifier, for: indexPath) as? PostDetailTableCell else { return UITableViewCell() }
            let data = postViewModel.commentTableData.valueData[indexPath.row]
            
            cell.cellConfigure(cell, indexPath)            
            cell.name.text = "\(data.user.username)"
            cell.comment.text = data.comment
            cell.button.addTarget(self, action: #selector(self.commentEditButtonClicked(_:)), for: .touchUpInside)
            cell.button.tag = indexPath.row
            return cell
        }
    }
}
