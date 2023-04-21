//
//  Stock.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/03/08.
//

import Foundation
import UIKit

struct Stock: Codable, Hashable {
    var imageURL: String?
    var code: String?
    var name: String?
    var dataList: [Double]?
    var price: Double?
    var priceDifference: Double?
    var isFavorite: Bool?

    private let identifier = UUID()

    init(imageURL: String? = nil, code: String? = nil, name: String? = nil, dataList: [Double]? = nil,
         price: Double? = nil, priceDifference: Double? = nil, isFavorite: Bool? = false) {
        self.imageURL = imageURL
        self.code = code
        self.name = name
        self.dataList = dataList
        self.price = price
        self.priceDifference = priceDifference
        self.isFavorite = isFavorite
    }

    enum CodingKeys: String, CodingKey {
        case imageURL
        case code
        case name
        case dataList
        case price = "closed_price"
        case priceDifference
        case isFavorite
    }

    static let all = [
        Stock(imageURL: "08.circle", code: "A0320042", name: "AAPL", dataList: [1,2,3], price: 111.00, priceDifference: 13),
        Stock(imageURL: "08.circle", code: "A0320042", name: "삼성전자", dataList: [1,2,3], price: 123.00, priceDifference: 12),
        Stock(imageURL: "08.circle", code: "A0320042", name: "Alphabet", dataList: [1,2,3], price: 333.33, priceDifference: 11),
        Stock(imageURL: "08.circle", code: "A0320042", name: "lotte", dataList: [1,2,3], price: 320000.11, priceDifference: 10),
    ]
}
