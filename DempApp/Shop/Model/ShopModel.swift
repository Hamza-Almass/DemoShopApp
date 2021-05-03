//
//  ShopModel.swift
//  DempApp
//
//  Created by Hamza Almass on 5/3/21.
//

import Foundation

// MARK: - Shop
struct Shop: Codable {
    let error: Bool
    let data: [ShopData]?
}

// MARK: - ShopData
struct ShopData: Codable {
    let name, details, address: String?
    let logo: String?
    let cover: String?
    let logoImageData: Data?
    let coverImageData: Data?
    let info: Info?
}

// MARK: - Info
struct Info: Codable {
    let lat, lng, nearestPoint: String?
}
