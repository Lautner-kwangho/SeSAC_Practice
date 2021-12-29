//
//  BeerViewModel.swift
//  Assignment59_RandomBeer
//
//  Created by 최광호 on 2021/12/29.
//

import Foundation
import UIKit

class BeerViewModel {
    
    var image = Genric(Data())
    var title = Genric(String())
    var subtitle = Genric(String())
    var content = Genric(String())
    var foodPairing = Genric(Array<String>())
    
    func requestAPI(_ BaseTableView: UITableView,_ TableView: UITableView) {
        APIManager.shared.beerAPI() { BeerData in
            
            DispatchQueue.main.async {
                if let data = BeerData.first {
                    do {
                        if let imageURL = data.imageURL {
                            let data = try Data(contentsOf: URL(string: imageURL)!)
                            self.image.value = data
                        }
                        
                    } catch {
                        print("error")
                    }
                    self.title.value = data.name
                    self.subtitle.value = data.tagline
                    self.content.value = data.beerDescription
                    self.foodPairing.value = data.foodPairing
                }
                BaseTableView.reloadData()
                TableView.reloadData()
            }
        }
    }
}

