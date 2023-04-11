//
//  Stock.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/03/08.
//

import Foundation
import UIKit

struct Stock: Hashable {
    let image: UIImage
    let code: String
    let name: String
    let dataList: [Double]
    var price: Double
    var priceDifference: Double
    var isFavorite: Bool

    init(image: UIImage, code: String, name: String, dataList: [Double], price: Double, priceDifference: Double, isFavorite: Bool = false) {
        self.image = image
        self.code = code
        self.name = name
        self.dataList = dataList
        self.price = price
        self.priceDifference = priceDifference
        self.isFavorite = isFavorite
    }

    private let identifier = UUID()

    static let all = [
        Stock(image: UIImage(systemName: "08.circle")!, code: "A0320042", name: "AAPL", dataList: [1,2,3], price: 111.00, priceDifference: 13),
        Stock(image: UIImage(systemName: "08.circle")!, code: "A0320042", name: "삼성전자", dataList: [1,2,3], price: 123.00, priceDifference: 12),
        Stock(image: UIImage(systemName: "08.circle")!, code: "A0320042", name: "Alphabet", dataList: [1,2,3], price: 333.33, priceDifference: 11),
        Stock(image: UIImage(systemName: "08.circle")!, code: "A0320042", name: "lotte", dataList: [1,2,3], price: 320000.11, priceDifference: 10),
    ]

}
