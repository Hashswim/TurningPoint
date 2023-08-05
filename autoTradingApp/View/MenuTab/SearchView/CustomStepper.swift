//
//  CustomStepper.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/07/19.
//

import UIKit

class CustomStepper: UIControl {

    private lazy var plusButton = stepperButton(color: viewData.color, bgImageName: "주식매수-매도 수량+", value: 1)
    private lazy var minusButton = stepperButton(color: viewData.color, bgImageName: "주식매수-매도 수량-", value: -1)

    private lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.text = "0"
        return label
    }()

    lazy var unitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blue
        label.textAlignment = .center
        return label
    }()

    lazy var container: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    struct ViewData {
        let color: UIColor
        let minimum: Double
        let maximum: Double
        let stepValue: Double
    }

    private (set) var value: Double = 0
    private let viewData: ViewData

    init(viewData: ViewData) {
        self.viewData = viewData
        super.init(frame: .zero)
        setup()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setValue(_ newValue: Double) {
        updateValue(min(viewData.maximum, max(viewData.minimum, newValue)))
    }

    private func setup() {
        backgroundColor = .white
        addSubview(container)

        [minusButton, counterLabel, unitLabel, plusButton].forEach(container.addArrangedSubview)

        container.setCustomSpacing(4, after: counterLabel)

        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),

            minusButton.widthAnchor.constraint(equalToConstant: 36),

            counterLabel.widthAnchor.constraint(equalToConstant: 48),

            unitLabel.widthAnchor.constraint(equalToConstant: 16),

            plusButton.widthAnchor.constraint(equalToConstant: 36),
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        plusButton.layer.cornerRadius = 0.5 * bounds.size.height
        minusButton.layer.cornerRadius = 0.5 * bounds.size.height
    }

    private func didPressedStepper(value: Double) {
        updateValue(value * viewData.stepValue)
    }

    private func updateValue(_ newValue: Double) {
        guard (viewData.minimum...viewData.maximum) ~= (value + newValue) else {
            return
        }
        value += newValue
        counterLabel.text = String(value.formatted())
        sendActions(for: .valueChanged)
    }

    private func stepperButton(color: UIColor, bgImageName: String, value: Int) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.setBackgroundImage(UIImage(named: bgImageName), for: .normal)
        button.tag = value
        button.setTitleColor(.white, for: .normal)
        return button
    }

    @objc private func buttonTapped(_ sender: UIButton) {
        didPressedStepper(value: Double(sender.tag))
    }
}

