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

    }
    override func configure() {
        self.title = viewModel.title
        
        let nibName = UINib(nibName: PostTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: PostTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        

        viewModel.getPost(self, tableView, 0, 10) {
        }
        
        postAddButton.setImage(UIImage(systemName: "plus"), for: .normal)
        postAddButton.addTarget(self, action: #selector(postAddButtonClicked), for: .touchUpInside)
    }
    
    @objc func postAddButtonClicked() {
        viewModel.writePost(self)
    }
    
    override func setupConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
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
        
        cell.cellConfigure(cell, indexPath)
        DispatchQueue.main.async {
            
            let data = self.viewModel.tableData.valueData[indexPath.row]
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

extension PostMainPageViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        DispatchQueue.main.async {
        let allCount = UserDefaults.standard.integer(forKey: "postCount")
        for indexPath in indexPaths {
            
            // 막판에 도와주셔서 다행히 보이긴 하지만 완전히 프리패치 된 건 아닌 거 같아요 ..
            // 안됐던 이유가 조건문으로 실행시키니까 안됐던 거더라구요
            // ⭐️⭐️⭐️
            // Mission Answers
            // 1.UserDefaults에 post count를 저장한 뒤에 이 값과 limit값을 비교해서 조건문을 만들면 되지 않을까 합니다 (post Count < limit)
            // 2. 총 개수를 모를 경우에는 생각만 해봤을 때, 만약 현재 값 ~ 리미트 값 을 10개로 받다가
            // 리미트 값에서 현재 값 차이가 10개 미만이면 그만 받는다! 이렇게 조건문 걸면 될 거 같아요
            // 만약 값이 같을 때를 대비해서 총 불러온 데이터를 set으로 필터한 개수와 비교하면 멈추지 않을까 합니다
            // 이거 수업시간이나 피드백에서 정답? 추천 방법? 알려주시나요? ㅎㅎ 알려주셨으면 좋겠습니다!
            self.viewModel.test.valueData += indexPath.row
            print(1)
            print(indexPath)
            print("이게 로우라는데", indexPath.row)
            print("data 총 개수",self.viewModel.tableData.valueData.count)
            print("VC", indexPaths)
//            print("data", self.viewModel.tableData.valueData)
            print("모델시작숫자",self.viewModel.startPage.valueData)
            print("모델제한숫자",self.viewModel.limitPage.valueData)
            if self.viewModel.tableData.valueData.count - 1 == indexPath.row {
                print("이부분 되긴 함? 조건문 다시 작성")
                self.viewModel.startPage.valueData += indexPath.row
                self.viewModel.limitPage.valueData += indexPath.row
                self.viewModel.getPost(self, self.tableView, self.viewModel.startPage.valueData, self.viewModel.limitPage.valueData) {
                }
            }
        }
//            p
    }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("혹시나 이거 때문인가 했는데 아니였음 ㅡㅡ", indexPaths)
    }
}
