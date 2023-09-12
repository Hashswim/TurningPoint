//
//  StcokListCellCollectionViewCell.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/03/08.
//

import UIKit
import Charts

fileprivate extension UIConfigurationStateCustomKey {
    static let stock = UIConfigurationStateCustomKey("StockListCell.stock")
}

private extension UICellConfigurationState {
    var stock: Stock? {
        get { return self[.stock] as? Stock }
        set { self[.stock] = newValue }
    }
}

class StcokListCellCollectionViewCell: UICollectionViewListCell {
    private var stock: Stock? = nil

    func updateWithItem(_ newStock: Stock) {
        guard stock != newStock else { return }
        stock = newStock
        setNeedsUpdateConfiguration()
    }

    override var configurationState: UICellConfigurationState {
        var state = super.configurationState
        state.stock = self.stock
        return state
    }
}

class CustomStcokListCellCollectionViewCell: StcokListCellCollectionViewCell {
    private func defaultListContentConfiguration() -> UIListContentConfiguration { return .subtitleCell() }

    private let iconView: UIImageView = {
        var imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
//        imgView.image = UIImage(named: "Dashin_test_img")
        return imgView
    }()

    private lazy var listContentView = UIListContentView(configuration: defaultListContentConfiguration())

    private let priceLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let priceDifferenceLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var priceStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [priceLabel, priceDifferenceLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 4

        return stackView
    }()

    var scaledChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = .clear

        chartView.rightAxis.enabled = false
        chartView.leftAxis.enabled = false
        chartView.xAxis.enabled = false
        chartView.legend.enabled = false

        chartView.animate(xAxisDuration: 2.5)
        chartView.dragEnabled = false
        return chartView
    }()

    private let additionalTradingCellView = AdditionalTradingCellView()

    private var customViewConstraints: (scaledChartViewLeading: NSLayoutConstraint,
                                        scaledChartViewTrailing: NSLayoutConstraint,
                                        priceLabelTrailing: NSLayoutConstraint)?

    private lazy var traidingViewConstraints1: NSLayoutConstraint = contentView.heightAnchor.constraint(equalToConstant: 94)
    private lazy var traidingViewConstraints2: NSLayoutConstraint = iconView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24)
    private lazy var traidingViewConstraints3: NSLayoutConstraint = listContentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16)

    // view 구성
    private func setupViewsIfNeeded() {
        // We only need to do anything if we haven't already setup the views and created constraints.
        guard customViewConstraints == nil else { return }

        self.backgroundColor = MySpecialColors.bgColor
        contentView.backgroundColor = MySpecialColors.darkGray
        contentView.addSubview(iconView)
        contentView.addSubview(listContentView)
        contentView.addSubview(scaledChartView)
        contentView.addSubview(priceStackView)

        contentView.layoutMargins = .zero
        contentView.preservesSuperviewLayoutMargins = true

        scaledChartView.translatesAutoresizingMaskIntoConstraints = false
        listContentView.translatesAutoresizingMaskIntoConstraints = false

//        let defaultHorizontalCompressionResistance = listContentView.contentCompressionResistancePriority(for: .horizontal)
//        listContentView.setContentCompressionResistancePriority(defaultHorizontalCompressionResistance - 1, for: .horizontal)

        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 33),
            iconView.widthAnchor.constraint(equalToConstant: 28),
            iconView.heightAnchor.constraint(equalToConstant: 28),
            iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),

//            listContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            listContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            listContentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            listContentView.leadingAnchor.constraint(equalTo: iconView.trailingAnchor),
            listContentView.heightAnchor.constraint(equalToConstant: 48),

            scaledChartView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 198),
            scaledChartView.centerYAnchor.constraint(equalTo: listContentView.centerYAnchor),
            scaledChartView.topAnchor.constraint(equalTo: listContentView.topAnchor),
//            scaledChartView.bottomAnchor.constraint(equalTo: listContentView.bottomAnchor),
            scaledChartView.widthAnchor.constraint(equalToConstant: 72),
            scaledChartView.heightAnchor.constraint(equalToConstant: 40),

            priceStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 298),
            priceStackView.centerYAnchor.constraint(equalTo: listContentView.centerYAnchor),

            priceStackView.heightAnchor.constraint(equalToConstant: 52),
            priceStackView.widthAnchor.constraint(equalToConstant: 66),

//            priceLabel.heightAnchor.constraint(equalToConstant: 20),
//            priceDifferenceLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }

    private var separatorConstraint: NSLayoutConstraint?
    private func updateSeparatorConstraint() {
        guard let textLayoutGuide = listContentView.textLayoutGuide else { return }
        if let existingConstraint = separatorConstraint, existingConstraint.isActive {
            return
        }
        let constraint = separatorLayoutGuide.leadingAnchor.constraint(equalTo: textLayoutGuide.leadingAnchor)
        constraint.isActive = true
        separatorConstraint = constraint
    }

    /// - Tag: UpdateConfiguration
    override func updateConfiguration(using state: UICellConfigurationState) {
        setupViewsIfNeeded()

        iconView.image = state.stock?.logo

        // Configure the list content configuration and apply that to the list content view.
        var content = defaultListContentConfiguration().updated(for: state)
        content.imageProperties.preferredSymbolConfiguration = .init(font: content.textProperties.font, scale: .large)
//        content.image = UIImage(named: state.stock!.logo!)

        content.attributedText = NSMutableAttributedString().medium(string: state.stock!.name!, fontSize: 15)
        content.secondaryAttributedText = NSMutableAttributedString().regular(string: state.stock!.code!, fontSize: 12)

        content.secondaryTextProperties.color = .gray
        content.textProperties.color = .white
        content.textToSecondaryTextVerticalPadding = -2
        content.imageToTextPadding = 4

        content.axesPreservingSuperviewLayoutMargins = []
        listContentView.configuration = content

        // Get the list value cell configuration for the current state, which we'll use to obtain the system default
        // styling and metrics to copy to our custom views.
        let valueConfiguration = UIListContentConfiguration.valueCell().updated(for: state)

        // Configure custom image view for the category icon, copying some of the styling from the value cell configuration.
        scaledChartView.tintColor = valueConfiguration.imageProperties.resolvedTintColor(for: tintColor)

            // MARK: -  시리얼 데이터 처리 어떻게 할지 정리 필요!!⭐️⭐️⭐️(DataEntry타입과 API로 인코딩되어 전달 받는 타입간 캐스팅 필요)
        var dataEntry1: [ChartDataEntry] = []
        var dataEntry2: [ChartDataEntry] = []

        for i in 0..<state.stock!.dateChartList!.count {
            dataEntry1.append(ChartDataEntry(x: Double(i), y: state.stock!.dateChartList![i].close))
            dataEntry2.append(ChartDataEntry(x: Double(i), y: state.stock!.dateChartList!.last!.close))
        }

        setData(dataEntry: dataEntry1, avgDataEntry: dataEntry2)

        // Configure custom label for the category name, copying some of the styling from the value cell configuration.
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        priceLabel.attributedText = NSMutableAttributedString().bold(string: numberFormatter.string(from: state.stock!.price! as NSNumber)!, fontSize: 17)
        priceLabel.textAlignment = .right
        priceLabel.textColor = state.stock!.priceDifference! > 0 ? MySpecialColors.lightRed : MySpecialColors.lightBlue
//        priceLabel.font = valueConfiguration.secondaryTextProperties.font
        //        priceLabel.adjustsFontForContentSizeCategory = valueConfiguration.secondaryTextProperties.adjustsFontForContentSizeCategory

//        numberFormatter.numberStyle = .percent
        if state.stock!.priceDifference! > 0 {
            priceDifferenceLabel.attributedText = NSMutableAttributedString()
                .medium(string: "+", fontSize: 12)
                .medium(string: String(format: "%.2f", state.stock!.priceDifference!), fontSize: 12)
                .medium(string: "%", fontSize: 12)
        } else if state.stock!.priceDifference! == 0 {
            priceDifferenceLabel.attributedText = NSMutableAttributedString()
            .medium(string: "0", fontSize: 12)
            .medium(string: "%", fontSize: 12)
        }
        else {
            priceDifferenceLabel.attributedText = NSMutableAttributedString()
                .medium(string: String(format: "%.2f", state.stock!.priceDifference!), fontSize: 12)
                .medium(string: "%", fontSize: 12)
        }

        priceDifferenceLabel.textColor = .white
        priceDifferenceLabel.layer.cornerRadius = 3
        priceDifferenceLabel.layer.masksToBounds = true
        priceDifferenceLabel.textAlignment = .center
        priceDifferenceLabel.backgroundColor = state.stock!.priceDifference! > 0 ? MySpecialColors.lightRed2 : MySpecialColors.lightBlue2

        if state.stock!.priceDifference! == 0 {
            priceDifferenceLabel.backgroundColor = .darkGray
            priceLabel.textColor = .white
        }

        customViewConstraints?.scaledChartViewLeading.constant = content.directionalLayoutMargins.trailing
        customViewConstraints?.scaledChartViewTrailing.constant = valueConfiguration.textToSecondaryTextHorizontalPadding
        customViewConstraints?.priceLabelTrailing.constant = content.directionalLayoutMargins.trailing
        updateSeparatorConstraint()

        if let istraiding = state.stock?.isTrading {
            if istraiding {
                traidingViewConstraints1.isActive = false
                traidingViewConstraints2.isActive = true
                traidingViewConstraints3.isActive = true
                additionalTradingCellView.translatesAutoresizingMaskIntoConstraints = false

                contentView.addSubview(additionalTradingCellView)

                let trainingStock = state.stock! as! TrainingStock
                additionalTradingCellView.earningPirceLabel.attributedText = NSMutableAttributedString()
                    .regular(string: numberFormatter.string(from: trainingStock.appamt! as NSNumber)!, fontSize: 17)
                    .medium(string: " 원", fontSize: 15)

                if trainingStock.sunikrt! > 0 {
                    additionalTradingCellView.earningRateLabel.attributedText = NSMutableAttributedString()
                        .regular(string: String(format: "+%.2f%%", trainingStock.sunikrt!), fontSize: 17)
                } else {
                    additionalTradingCellView.earningRateLabel.attributedText = NSMutableAttributedString()
                        .regular(string: String(format: "%.2f%%", trainingStock.sunikrt!), fontSize: 17)
                }

                additionalTradingCellView.ownedCountLabel.attributedText = NSMutableAttributedString()
                    .regular(string: numberFormatter.string(from: trainingStock.janqty! as NSNumber)!, fontSize: 17)
                    .medium(string: " 주", fontSize: 15)

                additionalTradingCellView.heightAnchor.constraint(equalToConstant: 128).isActive = true
                additionalTradingCellView.topAnchor.constraint(equalTo: listContentView.bottomAnchor, constant: 16).isActive = istraiding
                additionalTradingCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = istraiding
                additionalTradingCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = istraiding
                additionalTradingCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = istraiding
            } else {
                traidingViewConstraints1.isActive = true
                traidingViewConstraints2.isActive = false
                traidingViewConstraints3.isActive = false
                additionalTradingCellView.removeFromSuperview()
            }
        }
    }

    func updateAppearance() {

    }

    func setData(dataEntry chartData1: [ChartDataEntry], avgDataEntry chartData2: [ChartDataEntry]) {
        let set1 = LineChartDataSet(entries: chartData1, label: "")
        set1.mode = .cubicBezier
        set1.drawCirclesEnabled = false
        set1.lineWidth = 1

        set1.setColor(.white)

        let set2 = LineChartDataSet(entries: chartData2, label: "")
        set2.mode = .cubicBezier
        set2.drawCirclesEnabled = false
        set2.lineWidth = 1

        set2.setColor(.red)

        let data = LineChartData(dataSets: [set1, set2])
        data.setDrawValues(false)
        scaledChartView.data = data
    }
}


