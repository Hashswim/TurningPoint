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
    static let shcodeList = ["005930",
                             "373220",
                             "000660",
                             "207940",
                             "005490",

                             "005935",
                             "051910",
                             "006400",
                             "005380",
                             "003670",
                             
                             "035420",
                             "000270",]

    static var all: [Stock] = []

    static let favorite = [
        Stock(imageURL: "08.circle", code: "005930", name: "삼성전자", dataList: [1,2,3], price: 111, priceDifference: 0.13),
        Stock(imageURL: "08.circle", code: "373220", name: "LG에너지솔루션", dataList: [1,2,3], price: 123, priceDifference: 0.12),
        Stock(imageURL: "08.circle", code: "000660", name: "SK하이닉스", dataList: [1,2,3], price: 333, priceDifference: -0.11),
        Stock(imageURL: "08.circle", code: "207940", name: "삼성바이오로직스", dataList: [1,2,3], price: 3200, priceDifference: 0.10),
        Stock(imageURL: "08.circle", code: "005490", name: "POSCO홀딩스", dataList: [1,2,3], price: 111, priceDifference: -0.13),
        Stock(imageURL: "08.circle", code: "005935", name: "삼성전자우", dataList: [1,2,3], price: 123, priceDifference: 0.12),
        Stock(imageURL: "08.circle", code: "051910", name: "LG화학", dataList: [1,2,3], price: 111, priceDifference: -0.13),
    ]

    static let traiding = [
        Stock(imageURL: "08.circle", code: "005930", name: "삼성전자", dataList: [1,2,3], price: 111, priceDifference: 0.13),
        Stock(imageURL: "08.circle", code: "035420", name: "NAVER", dataList: [1,2,3], price: 123, priceDifference: 0.12),
        Stock(imageURL: "08.circle", code: "000270", name: "기아", dataList: [1,2,3], price: 123, priceDifference: 0.12),
    ]
}
