//
//  TransactionStackView.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/08/25.
//

import UIKit

enum OrderIndex: String {
    case buy = "매수"
    case sell = "매도"
}

struct TradingCall {
    let code: String?
    let name: String?
    let price: Double?
    let count: Int?
    let order: OrderIndex?
}

class TransactionButton: UIButton {
    var tradingCall = TradingCall(code: nil, name: nil, price: nil, count: nil, order: nil)

    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
//        view.distribution = .fill
//        view.spacing = 12
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
//        label.text = "네이버"
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let priceLabel: UILabel = {
        let label = UILabel()
//        label.text = "210,000원"
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true

        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let countLabel: UILabel = {
        let label = UILabel()
//        label.text = "3개"
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true

        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let orderLabel: UILabel = {
        let label = UILabel()
//        label.text = "매수"
        label.textAlignment = .left
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect){
        super.init(frame: frame)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpCallValue() {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        nameLabel.attributedText = NSMutableAttributedString().bold(string: tradingCall.name ?? "", fontSize: 17)
        priceLabel.attributedText = NSMutableAttributedString()
            .bold(string: numberFormatter.string(from: tradingCall.price! as NSNumber)!, fontSize: 17)
            .regular(string: "원", fontSize: 17)
        countLabel.attributedText = NSMutableAttributedString()
            .bold(string: String(tradingCall.count!), fontSize: 17)
            .regular(string: "개", fontSize: 17)
        orderLabel.attributedText = NSMutableAttributedString().bold(string: tradingCall.order!.rawValue, fontSize: 17)

        switch tradingCall.order! {
        case .buy:
            orderLabel.textColor = MySpecialColors.orderRed
        case .sell:
            orderLabel.textColor = MySpecialColors.orderBlue
        }
    }


    private func setUp() {
        addSubview(stackView)
        [nameLabel, priceLabel, countLabel, orderLabel].forEach(stackView.addArrangedSubview(_:))

        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10

        self.backgroundColor = MySpecialColors.bgGray

        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),

            nameLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 18),
            nameLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 12),
            nameLabel.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -12),
            nameLabel.widthAnchor.constraint(equalToConstant: 60),

            priceLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10),
            priceLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 12),
            priceLabel.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -12),
            priceLabel.widthAnchor.constraint(equalToConstant: 60),

            countLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 16),
            countLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 12),
            countLabel.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -12),
            countLabel.widthAnchor.constraint(equalToConstant: 30),

            orderLabel.leadingAnchor.constraint(equalTo: countLabel.trailingAnchor, constant: 4),
            orderLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 12),
            orderLabel.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -12),
            orderLabel.widthAnchor.constraint(equalToConstant: 40),

        ])
    }

}
