//
//  MainDramaCollectionView.swift
//  Assignment60_Drama
//
//  Created by 최광호 on 2021/12/24.
//

import UIKit

class MainDramaCollectionView: BaseCollectionView {
    
    let dramaSearchBar = UISearchBar()
    
    let dramaCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
        let layer = UICollectionViewFlowLayout()
        layer.scrollDirection = .vertical
        $0.collectionViewLayout = layer
        // ㅜㅜ 드뎌
        $0.register(MainDramaCell.self, forCellWithReuseIdentifier: MainDramaCell.reuseIdentifier)
        $0.register(MainDramaReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MainDramaReusableView.reuseIdentifier)
        $0.backgroundColor = .black
    }
    
    var tvData: TV?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiRequest()
        configure()
        setupConstraints()
    }
    
    func apiRequest() {
        APIManager.shared.tvPopularAPI { tv in
            self.tvData = tv
            
            DispatchQueue.main.async {
//                dump(self.tvData)
                self.dramaCollectionView.reloadData()
            }
        }
    }

    override func configure() {
        view.backgroundColor = .black
        
        
        navigationItem.titleView = dramaSearchBar
        
        [dramaCollectionView].forEach {
            view.addSubview($0)
        }

        dramaCollectionView.delegate = self
        dramaCollectionView.dataSource = self
    }

    override func setupConstraints() {
        dramaCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize.init(width: width / 3 - 5, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 90
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainDramaCell.reuseIdentifier, for: indexPath) as? MainDramaCell else {
            return UICollectionViewCell()
        }
        
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 5
        
        let item = self.tvData?.results.[indexPath.item]
        
        do {
            if let poster = item?.posterPath {
                let data = try Data(contentsOf: URL(string: "https://image.tmdb.org/t/p/original/" + poster)!)
                cell.imageView.image = UIImage(data: data)
            }~
        } catch {
            print("ERROR")
        }
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MainDramaReusableView.reuseIdentifier, for: indexPath)
            return header
        default:
            print("Footer NoNo")
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.frame.width
        let height: CGFloat = 50
        return CGSize(width: width, height: height)
    }

}

