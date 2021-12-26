//
//  DetailDramaTableView.swift
//  Assignment60_Drama
//
//  Created by 최광호 on 2021/12/27.
//

import UIKit

class DetailDramaTableView: BaseTableView {
    
    let tableView = UITableView().then {
        $0.backgroundColor = .black
        $0.register(DetailDramaCell.self, forCellReuseIdentifier: DetailDramaCell.reuseIdentifier)
    }
    
    var searchData: Search?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchAPI()
        configure()
        setupConstraints()
    }
    
    func setSearchAPI() {
        APIManager.shared.searchAPI { searchData in
            self.searchData = searchData
            DispatchQueue.main.async {
                dump(self.searchData)
                self.tableView.reloadData()
            }
        }
    }
    override func configure() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let number = self.searchData?.results.count {
            return number
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailDramaCell.reuseIdentifier, for: indexPath) as? DetailDramaCell else {
            return UITableViewCell()
        }
        
        do {
            if let data = self.searchData?.results[indexPath.item] {
                let image = try! Data(contentsOf: URL(string: "https://image.tmdb.org/t/p/w500" + data.posterPath)!)
                cell.posterImage.image = UIImage(data: image)
                cell.title.text = data.name
                cell.date.text = data.firstAirDate
                cell.content.text = data.overview
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
