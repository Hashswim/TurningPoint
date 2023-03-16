//
//  StcokListCellCollectionViewCell.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/03/08.
//

import UIKit
import LightweightCharts

fileprivate extension UIConfigurationStateCustomKey {
    static let stock = UIConfigurationStateCustomKey("StockListCell.stock")
}

private extension UICellConfigurationState {
    var stock: Stock? {
        set { self[.stock] = newValue }
        get { return self[.stock] as? Stock }
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

    private let scaledChartView = OverViewChartView()
    private var customViewConstraints: (scaledChartViewLeading: NSLayoutConstraint,
                                        scaledChartViewTrailing: NSLayoutConstraint,
                                        priceLabelTrailing: NSLayoutConstraint)?


    // view 구성
    private func setupViewsIfNeeded() {
        // We only need to do anything if we haven't already setup the views and created constraints.
        guard customViewConstraints == nil else { return }

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
        content.image = state.stock?.image
        content.text = state.stock?.name
        content.secondaryText = state.stock?.code
        content.axesPreservingSuperviewLayoutMargins = []
        listContentView.configuration = content

        // Get the list value cell configuration for the current state, which we'll use to obtain the system default
        // styling and metrics to copy to our custom views.
        let valueConfiguration = UIListContentConfiguration.valueCell().updated(for: state)

        // Configure custom image view for the category icon, copying some of the styling from the value cell configuration.
        scaledChartView.tintColor = valueConfiguration.imageProperties.resolvedTintColor(for: tintColor)
//        scaledChartView.preferredSymbolConfiguration = .init(font: valueConfiguration.secondaryTextProperties.font, scale: .small)

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
    }
}
