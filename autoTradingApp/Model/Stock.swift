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
    var dateChartList: [DateChart]?
    var price: Double?
    var priceDifference: Double?
    var volume: Double?
    var change: Double?
    var isFavorite: Bool?
    var isTrading: Bool?

//    private let identifier = UUID()

    init(logo: UIImage? = nil, code: String? = nil, name: String? = nil, dataList: [DateChart]? = nil,
         price: Double? = nil, priceDifference: Double? = nil, volume: Double? = nil, change: Double? = nil,
         isFavorite: Bool? = false, isTrading: Bool? = false) {
        self.logo = logo
        self.code = code
        self.name = name
        self.dateChartList = dataList
        self.price = price
        self.priceDifference = priceDifference
        self.volume = volume
        self.change = change
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
                             "000270"]

    static var homePageDict: [String: String] = ["005930": "https://logo.clearbit.com/https://www.samsung.com",
                                                 "373220": "https://logo.clearbit.com/https://www.lgensol.com",
                                                 "000660": "https://logo.clearbit.com/https://www.sk.co.kr/",
                                                 "207940": "https://logo.clearbit.com/https://samsungbiologics.com",
                                                 "005490": "https://logo.clearbit.com/https://www.posco.co.kr",
                                                 "005935": "https://logo.clearbit.com/https://www.samsung.com",
                                                 "051910": "https://logo.clearbit.com/https://www.lgchem.com",
                                                 "006400": "https://logo.clearbit.com/https://www.samsungsdi.co.kr",
                                                 "005380": "https://logo.clearbit.com/https://www.hyundai.com",
                                                 "003670": "https://logo.clearbit.com/http://www.posco.co.kr",
                                                 "035420": "https://logo.clearbit.com/https://www.naver.com",
                                                 "000270": "https://logo.clearbit.com/https://www.kia.com"]

    static var all: [Stock] = []
    static var loaded: [Stock] = []

    static var favorite: [Stock] = []

    static var traiding: [TrainingStock] = []
}

class OwnedStock: Stock {
    var appamt: Double?//평가금액
    var dtsunik: Double?//평가손익
    var sunikrt: Double?//수익률
    var janqty: Double?//수량

    init(name: String? = nil, code: String? = nil, appamt: Double? = nil, dtsunik: Double? = nil, sunikrt: Double? = nil, janqty: Double? = nil) {
        super.init()
        self.name = name
        self.code = code

        self.appamt = appamt
        self.dtsunik = dtsunik
        self.sunikrt = sunikrt
        self.janqty = janqty
    }
}

class TrainingStock: OwnedStock {
    var modelList: [AlgorithmModel]?
    var trainingModel: AlgorithmModel?

    init(ownedStock: OwnedStock, modelList: [AlgorithmModel]? = nil, trainingModel: AlgorithmModel? = nil) {
        super.init()

        self.modelList = modelList
        self.trainingModel = trainingModel

        self.logo = ownedStock.logo
        self.code = ownedStock.code
        self.name = ownedStock.name
        self.dateChartList = ownedStock.dateChartList
        self.price = ownedStock.price
        self.priceDifference = ownedStock.priceDifference
        self.volume = ownedStock.volume
        self.change = ownedStock.change
        self.isFavorite = ownedStock.isFavorite
        self.isTrading = ownedStock.isTrading

        self.appamt = ownedStock.appamt
        self.dtsunik = ownedStock.dtsunik
        self.sunikrt = ownedStock.sunikrt
        self.janqty = ownedStock.janqty


        self.isTrading = true
    }
}

struct DateChart {
    var date: String
    var high: Double
    var low: Double
    var open: Double
    var close: Double
}
