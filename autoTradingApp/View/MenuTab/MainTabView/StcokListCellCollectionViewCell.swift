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

        return chartView
    }()

    private var customViewConstraints: (scaledChartViewLeading: NSLayoutConstraint,
                                        scaledChartViewTrailing: NSLayoutConstraint,
                                        priceLabelTrailing: NSLayoutConstraint)?

    private lazy var traidingViewConstraints: NSLayoutConstraint = listContentView.heightAnchor.constraint(equalToConstant: 200)

    // view 구성
    private func setupViewsIfNeeded() {
        // We only need to do anything if we haven't already setup the views and created constraints.
        guard customViewConstraints == nil else { return }

        contentView.backgroundColor = .clear
        contentView.addSubview(listContentView)
        contentView.addSubview(scaledChartView)
        contentView.addSubview(priceStackView)

        scaledChartView.translatesAutoresizingMaskIntoConstraints = false
        listContentView.translatesAutoresizingMaskIntoConstraints = false
        let defaultHorizontalCompressionResistance = listContentView.contentCompressionResistancePriority(for: .horizontal)
        listContentView.setContentCompressionResistancePriority(defaultHorizontalCompressionResistance - 1, for: .horizontal)

        NSLayoutConstraint.activate([
            listContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            listContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            listContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            listContentView.heightAnchor.constraint(equalToConstant: 200),

            scaledChartView.leadingAnchor.constraint(equalTo: listContentView.trailingAnchor),
            scaledChartView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            scaledChartView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            scaledChartView.widthAnchor.constraint(equalToConstant: 40),

            priceStackView.leadingAnchor.constraint(equalTo: scaledChartView.trailingAnchor),
            //            priceStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            //            priceStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            //            priceStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),

            //            priceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            //            scaledChartView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

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

        // Configure the list content configuration and apply that to the list content view.
        var content = defaultListContentConfiguration().updated(for: state)
        content.imageProperties.preferredSymbolConfiguration = .init(font: content.textProperties.font, scale: .large)
        content.image = UIImage(named: state.stock!.imageURL!)
        content.text = state.stock?.name
        content.secondaryText = state.stock?.code
        content.axesPreservingSuperviewLayoutMargins = []
        listContentView.configuration = content

        // Get the list value cell configuration for the current state, which we'll use to obtain the system default
        // styling and metrics to copy to our custom views.
        let valueConfiguration = UIListContentConfiguration.valueCell().updated(for: state)

        // Configure custom image view for the category icon, copying some of the styling from the value cell configuration.
        scaledChartView.tintColor = valueConfiguration.imageProperties.resolvedTintColor(for: tintColor)

            // MARK: -  시리얼 데이터 처리 어떻게 할지 정리 필요!!⭐️⭐️⭐️(DataEntry타입과 API로 인코딩되어 전달 받는 타입간 캐스팅 필요)
        let dataEntry1 = [
            ChartDataEntry(x: state.stock!.dataList![0], y: state.stock!.dataList![0]),
            ChartDataEntry(x: state.stock!.dataList![1], y: state.stock!.dataList![1]),
            ChartDataEntry(x: state.stock!.dataList![2], y: state.stock!.dataList![2]),
        ]

        let dataEntry2 = [
            ChartDataEntry(x: state.stock!.dataList![0], y: state.stock!.dataList![0]),
            ChartDataEntry(x: state.stock!.dataList![1], y: state.stock!.dataList![1]),
            ChartDataEntry(x: state.stock!.dataList![2], y: state.stock!.dataList![2]),
        ]
        setData(dataEntry: dataEntry1, avgDataEntry: dataEntry2)

        // Configure custom label for the category name, copying some of the styling from the value cell configuration.
        priceLabel.text = String(describing: state.stock?.price)
        priceLabel.textColor = valueConfiguration.secondaryTextProperties.resolvedColor()
        priceLabel.font = valueConfiguration.secondaryTextProperties.font
        //        priceLabel.adjustsFontForContentSizeCategory = valueConfiguration.secondaryTextProperties.adjustsFontForContentSizeCategory

        priceDifferenceLabel.text = String(describing: state.stock?.price)
        priceDifferenceLabel.textColor = valueConfiguration.secondaryTextProperties.resolvedColor()
        priceDifferenceLabel.font = valueConfiguration.secondaryTextProperties.font

        // Update some of the constraints for our custom views using the system default metrics from the configurations.
        customViewConstraints?.scaledChartViewLeading.constant = content.directionalLayoutMargins.trailing
        customViewConstraints?.scaledChartViewTrailing.constant = valueConfiguration.textToSecondaryTextHorizontalPadding
        customViewConstraints?.priceLabelTrailing.constant = content.directionalLayoutMargins.trailing
        updateSeparatorConstraint()

        if let istraiding = state.stock?.isTraiding {
            traidingViewConstraints.isActive = istraiding
        }
    }

    func updateAppearance() {
        traidingViewConstraints.isActive = isSelected

//        openConstraint?.isActive = isSelected

//            UIView.animate(withDuration: 0.3) { // 0.3 seconds matches collection view animation
//                // Set the rotation just under 180º so that it rotates back the same way
//                let upsideDown = CGAffineTransform(rotationAngle: .pi * 0.999 )
//                self.disclosureIndicator.transform = self.isSelected ? upsideDown :.identity
//            }
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


