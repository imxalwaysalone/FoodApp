//
//  Model.swift
//  FoodApp
//
//  Created by Владимир Дроздов on 17.07.23.
//

import Foundation

struct Categories: Decodable {
    let сategories: [Category]
}

struct Category:Decodable {
    let id: Int
    let name: String
    let image_url: URL
}

