//
//  Stock.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/03/08.
//

import Foundation
import UIKit

class Stock: Hashable {
    static func == (lhs: Stock, rhs: Stock) -> Bool {
        lhs === rhs
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(code)
    }

    var logo: UIImage?
    var code: String?
    var name: String?
    var dataList: [Double]?
    var price: Double?
    var priceDifference: Double?
    var isFavorite: Bool?
    var isTrading: Bool?

//    private let identifier = UUID()

    init(logo: UIImage? = nil, code: String? = nil, name: String? = nil, dataList: [Double]? = nil,
         price: Double? = nil, priceDifference: Double? = nil, isFavorite: Bool? = false, isTrading: Bool? = false) {
        self.logo = logo
        self.code = code
        self.name = name
        self.dataList = dataList
        self.price = price
        self.priceDifference = priceDifference
        self.isFavorite = isFavorite
        self.isTrading = isTrading
    }

    enum CodingKeys: String, CodingKey {
        case logo
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

    static let homePageDict: [String: String] = ["005930": "https://logo.clearbit.com/https://www.samsung.com",
                                                 "373220": "https://logo.clearbit.com/https://www.lgensol.com",
                                                 "000660": "https://logo.clearbit.com/https://www.sk.co.kr/",
                                                 "207940": "https://logo.clearbit.com/https://samsungbiologics.com",
                                                 "005490": "https://logo.clearbit.com/https://www.posco-inc.com",
                                                 "005935": "https://logo.clearbit.com/https://www.samsung.com",
                                                 "051910": "https://logo.clearbit.com/https://www.lgchem.com",
                                                 "006400": "https://logo.clearbit.com/https://www.samsungsdi.co.kr",
                                                 "005380": "https://logo.clearbit.com/https://www.hyundai.com",
                                                 "003670": "https://logo.clearbit.com/http://www.poscofuturem.com",
                                                 "035420": "https://logo.clearbit.com/https://www.naver.com",
                                                 "000270": "https://logo.clearbit.com/https://www.kia.com"]

    static var all: [Stock] = []

    static var favorite: [Stock] = []

    static let traiding: [Stock] = []
}
