//
//  TransactionView.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/07/19.
//

import UIKit

class TransactionView: UIView {

    private let typeLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSMutableAttributedString().medium(string: "주문 수량", fontSize: 20)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    let countStepper: CustomStepper = {
        let stepper = CustomStepper(viewData: .init(color: .gray, minimum: 0, maximum: 100, stepValue: 1))
        stepper.unitLabel.text = "주"
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()

    let priceStepper: CustomStepper = {
        let stepper = CustomStepper(viewData: .init(color: .gray, minimum: 0, maximum: 1000000, stepValue: 1000))
        stepper.unitLabel.text = "원"
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()

    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let totalPriceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .white
        return stackView
    }()

    private let totalLabel1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "총"
        label.textAlignment = .right
        label.textColor = .gray

        return label
    }()

    let totalPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.attributedText = NSMutableAttributedString().bold(string: "0", fontSize: 28)
        label.textColor = .black

        return label
    }()

    private let totalLabel2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "원"
        label.textColor = .gray

        return label
    }()

    private let totalPriceImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage(named: "주식매수-매도총액계산기")
        
        return imgView
    }()

    let transactionButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .blue
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true

        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setUpUI()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpUI() {
        self.addSubview(typeLabel)
        self.addSubview(countStepper)
        self.addSubview(priceStepper)
        self.addSubview(lineView)
        self.addSubview(totalPriceStackView)
        self.addSubview(totalPriceImageView)
        self.addSubview(transactionButton)

        [totalLabel1, totalPriceLabel, totalLabel2].forEach(totalPriceStackView.addArrangedSubview)

        totalPriceStackView.setCustomSpacing(12, after: totalLabel1)
        totalPriceStackView.setCustomSpacing(3, after: totalPriceLabel)

        self.backgroundColor = .white
    }

    func configureLayout() {
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 46),
            typeLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            typeLabel.widthAnchor.constraint(equalToConstant: 80),
            typeLabel.heightAnchor.constraint(equalToConstant: 29),

            countStepper.leadingAnchor.constraint(equalTo: typeLabel.trailingAnchor, constant: 88),
            countStepper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 46),
            countStepper.widthAnchor.constraint(equalToConstant: 166),
            countStepper.heightAnchor.constraint(equalToConstant: 36),

            priceStepper.leadingAnchor.constraint(equalTo: typeLabel.trailingAnchor, constant: 88),
            priceStepper.topAnchor.constraint(equalTo: countStepper.bottomAnchor, constant: 12),
            priceStepper.widthAnchor.constraint(equalToConstant: 166),
            priceStepper.heightAnchor.constraint(equalToConstant: 36),

            lineView.topAnchor.constraint(equalTo: priceStepper.bottomAnchor, constant: 22),
            lineView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            lineView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            lineView.heightAnchor.constraint(equalToConstant: 1),

            totalPriceStackView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 22),
            totalPriceStackView.widthAnchor.constraint(equalToConstant: 200),
            totalPriceStackView.heightAnchor.constraint(equalToConstant: 42),
            totalPriceStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -70),

            totalLabel1.topAnchor.constraint(equalTo: totalPriceStackView.topAnchor),
            totalPriceLabel.topAnchor.constraint(equalTo: totalPriceStackView.topAnchor, constant: -8),
            totalLabel2.topAnchor.constraint(equalTo: totalPriceStackView.topAnchor),

            totalPriceImageView.widthAnchor.constraint(equalToConstant: 40),
            totalPriceImageView.heightAnchor.constraint(equalToConstant: 40),
            totalPriceImageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            totalPriceImageView.centerYAnchor.constraint(equalTo: totalPriceStackView.centerYAnchor),

            transactionButton.topAnchor.constraint(equalTo: totalPriceStackView.bottomAnchor, constant: 40),
            transactionButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            transactionButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            transactionButton.heightAnchor.constraint(equalToConstant: 52),
        ])
    }

}
