//
//  Beer.swift
//  Assignment59_RandomBeer
//
//  Created by 최광호 on 2021/12/21.
//

import Foundation

// MARK: - BeerElement
struct Beer: Codable {
    let id: Int
    let name, tagline, firstBrewed, beerDescription: String
    let imageURL: String?
    let abv: Double
    let ibu, targetFg, targetOg, ebc: Double?
    let srm, ph, attenuationLevel: Double?
    let foodPairing: [String]
    let brewersTips, contributedBy: String

    enum CodingKeys: String, CodingKey {
        case id, name, tagline
        case firstBrewed = "first_brewed"
        case beerDescription = "description"
        case imageURL = "image_url"
        case abv, ibu
        case targetFg = "target_fg"
        case targetOg = "target_og"
        case ebc, srm, ph
        case attenuationLevel = "attenuation_level"
        case foodPairing = "food_pairing"
        case brewersTips = "brewers_tips"
        case contributedBy = "contributed_by"
    }
}
