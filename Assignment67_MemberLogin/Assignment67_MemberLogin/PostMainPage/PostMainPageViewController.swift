//
//  PostMainPageViewController.swift
//  Assignment67_MemberLogin
//
//  Created by 최광호 on 2022/01/04.
//

import UIKit

class PostMainPageViewController: BaseView {
    
    static let tableView = UITableView().then {
        $0.backgroundColor = .systemGray4
    }
    let postAddButton = UIButton().then {
        $0.backgroundColor = .systemGreen
        $0.tintColor = .white
        $0.layer.cornerRadius = 25
    }
    
    let viewModel = PostMainPageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewDidApperAction()
    }
    
    override func configure() {
        self.title = viewModel.title
        
        let nibName = UINib(nibName: PostTableViewCell.reuseIdentifier, bundle: nil)
        PostMainPageViewController.tableView.register(nibName, forCellReuseIdentifier: PostTableViewCell.reuseIdentifier)
        PostMainPageViewController.tableView.delegate = self
        PostMainPageViewController.tableView.dataSource = self
        PostMainPageViewController.tableView.prefetchDataSource = self
        
        // test
        let rightButton = UIBarButtonItem(title: "새로고침", style: .plain, target: self, action: #selector(reloadButtonClicked))
        navigationItem.rightBarButtonItem = rightButton
        
        postAddButton.setImage(UIImage(systemName: "plus"), for: .normal)
        postAddButton.addTarget(self, action: #selector(postAddButtonClicked), for: .touchUpInside)
    }
    
    @objc func reloadButtonClicked() {
        //test용임
        viewModel.getPost(self, PostMainPageViewController.tableView, viewModel.startPage.valueData)
        dump(viewModel.tableViewNumberOfRows)
    }
    
    @objc func postAddButtonClicked() {
        viewModel.writePost(self)
    }
    
    override func setupConstraints() {
        view.addSubview(PostMainPageViewController.tableView)
        PostMainPageViewController.tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        view.addSubview(postAddButton)
        postAddButton.snp.makeConstraints {
            $0.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.width.height.equalTo(50)
        }
    }

}

extension PostMainPageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableViewNumberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.reuseIdentifier, for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
        let data = self.viewModel.tableData.valueData[indexPath.row]
        
        cell.cellConfigure(cell, indexPath)
        cell.name.text = data.user.username
        cell.content.text = data.text
        cell.date.text = self.viewModel.dateFormatter(at: indexPath)
        cell.commentButton.setTitle(self.viewModel.commentCount(at: indexPath), for: .normal)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 4
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PostDetailViewController()
        let data = viewModel.tableData.valueData[indexPath.row]
        vc.viewModel = data
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension PostMainPageViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        DispatchQueue.main.async {
            let allCount = UserDefaults.standard.integer(forKey: "postCount")
            for indexPath in indexPaths {
                
                // ⭐️⭐️⭐️
                // Mission Answers
                // 1.UserDefaults에 post count를 저장한 뒤에 이 값과 limit값을 비교해서 조건문을 만들면 되지 않을까 합니다 (post Count < limit)
                // 2. 총 개수를 모를 경우에는 생각만 해봤을 때, 만약 현재 값 ~ 리미트 값 을 10개로 받다가
                // 리미트 값에서 현재 값 차이가 10개 미만이면 그만 받는다! 이렇게 조건문 걸면 될 거 같아요
                // 만약 값이 같을 때를 대비해서 총 불러온 데이터를 set으로 필터한 개수와 비교하면 멈추지 않을까 합니다
                
                if self.viewModel.tableData.valueData.count - 1 == indexPath.row {
                    
                    self.viewModel.limitPage.receiveData { value in
                        if allCount > value {
                            print("이부분 되긴 함? 조건문 다시 작성")
                            self.viewModel.startPage.valueData += 10
                            self.viewModel.getPost(self, PostMainPageViewController.tableView, self.viewModel.startPage.valueData)
                            
                        }
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("여기 부분 취소되고 넘어감")
    }
}
