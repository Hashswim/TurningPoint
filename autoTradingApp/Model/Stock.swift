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
    let name: String
    var price: Double
    var priceDifference: Double

    init(image: UIImage, name: String, price: Double, priceDifference: Double) {
        self.image = image
        self.name = name
        self.price = price
        self.priceDifference = priceDifference
    }

    private let identifier = UUID()

    static let all = [
        Stock(image: UIImage(systemName: "08.circle")!, name: "AAPL", price: 111.00, priceDifference: 13),
        Stock(image: UIImage(systemName: "08.circle")!, name: "삼성전자", price: 123.00, priceDifference: 12),
        Stock(image: UIImage(systemName: "08.circle")!, name: "Alphabet", price: 333.33, priceDifference: 11),
        Stock(image: UIImage(systemName: "08.circle")!, name: "lotte", price: 320000.11, priceDifference: 10),
    ]

}
