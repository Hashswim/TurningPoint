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
    var isTrading: Bool?

    private let identifier = UUID()

    init(imageURL: String? = nil, code: String? = nil, name: String? = nil, dataList: [Double]? = nil,
         price: Double? = nil, priceDifference: Double? = nil, isFavorite: Bool? = false, isTrading: Bool? = false) {
        self.imageURL = imageURL
        self.code = code
        self.name = name
        self.dataList = dataList
        self.price = price
        self.priceDifference = priceDifference
        self.isFavorite = isFavorite
        self.isTrading = isTrading
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
        Stock(imageURL: "08.circle", code: "A0320042", name: "AAPL", dataList: [1,2,3], price: 111, priceDifference: 0.13),
        Stock(imageURL: "08.circle", code: "A0320042", name: "삼성전자", dataList: [1,2,3], price: 123, priceDifference: 0.12),
        Stock(imageURL: "08.circle", code: "A0320042", name: "Alphabet", dataList: [1,2,3], price: 333, priceDifference: -0.11),
        Stock(imageURL: "08.circle", code: "A0320042", name: "lotte", dataList: [1,2,3], price: 3200, priceDifference: 0.10),
        Stock(imageURL: "08.circle", code: "A0320042", name: "AAPL", dataList: [1,2,3], price: 111, priceDifference: -0.13),
        Stock(imageURL: "08.circle", code: "A0320042", name: "삼성전자", dataList: [1,2,3], price: 123, priceDifference: 0.12),
        Stock(imageURL: "08.circle", code: "A0320042", name: "AAPL", dataList: [1,2,3], price: 111, priceDifference: -0.13),
        Stock(imageURL: "08.circle", code: "A0320042", name: "삼성전자", dataList: [1,2,3], price: 123, priceDifference: -0.12),
        Stock(imageURL: "08.circle", code: "A0320042", name: "AAPL", dataList: [1,2,3], price: 111, priceDifference: 0.13),
        Stock(imageURL: "08.circle", code: "A0320042", name: "삼성전자", dataList: [1,2,3], price: 123, priceDifference: 0.12),
    ]

    static let favorite = [
        Stock(imageURL: "08.circle", code: "A0320042", name: "AAPL", dataList: [1,2,3], price: 111, priceDifference: -0.13),
        Stock(imageURL: "08.circle", code: "A0320042", name: "삼성전자", dataList: [1,2,3], price: 123, priceDifference: -0.12),
        Stock(imageURL: "08.circle", code: "A0320042", name: "AAPL", dataList: [1,2,3], price: 111, priceDifference: 0.13),
        Stock(imageURL: "08.circle", code: "A0320042", name: "삼성전자", dataList: [1,2,3], price: 123, priceDifference: 0.12),
        Stock(imageURL: "08.circle", code: "A0320042", name: "AAPL", dataList: [1,2,3], price: 111, priceDifference: 0.13),
        Stock(imageURL: "08.circle", code: "A0320042", name: "삼성전자", dataList: [1,2,3], price: 123, priceDifference: 0.12),
        Stock(imageURL: "08.circle", code: "A0320042", name: "AAPL", dataList: [1,2,3], price: 111, priceDifference: 0.13),
        Stock(imageURL: "08.circle", code: "A0320042", name: "삼성전자", dataList: [1,2,3], price: 123, priceDifference: 0.12),
    ]

    static let traiding = [
        Stock(imageURL: "08.circle", code: "A0320042", name: "AAPL", dataList: [1,2,3], price: 111, priceDifference: 0.13, isTrading: true),
        Stock(imageURL: "08.circle", code: "A0320042", name: "Alphabet", dataList: [1,2,3], price: 333, priceDifference: 0.11, isTrading: true),
        Stock(imageURL: "08.circle", code: "A0320042", name: "lotte", dataList: [1,2,3], price: 320000, priceDifference: -0.10, isTrading: true),
        Stock(imageURL: "08.circle", code: "A0320042", name: "lotte", dataList: [1,2,3], price: 320000, priceDifference: 0.10, isTrading: true),
        Stock(imageURL: "08.circle", code: "A0320042", name: "lotte", dataList: [1,2,3], price: 320000, priceDifference: 0.10, isTrading: true),
        Stock(imageURL: "08.circle", code: "A0320042", name: "lotte", dataList: [1,2,3], price: 320000, priceDifference: 0.10, isTrading: true),
        Stock(imageURL: "08.circle", code: "A0320042", name: "lotte", dataList: [1,2,3], price: 320000, priceDifference: -0.10, isTrading: true),
    ]
}
