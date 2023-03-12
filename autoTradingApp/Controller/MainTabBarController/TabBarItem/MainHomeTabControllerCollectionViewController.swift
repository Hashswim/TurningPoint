//
//  MainHomeTabControllerCollectionViewController.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/03/09.
//

import UIKit

private let reuseIdentifier = "Cell"

private enum Section: Hashable {
    case main
}

class MainHomeTabControllerCollectionViewController: UIViewController {

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이수림님"
        label.font = .systemFont(ofSize: 20)
        return label
    }()

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "2023.03.09"
        label.font = .systemFont(ofSize: 10)

        return label
    }()

    private let refreshButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "arrow.2.circlepath"), for: .normal)
        return btn
    }()

    lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, timeLabel, refreshButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal

        return stackView
    }()

    private let segmentedControl = mainTabSegmentedControl(items: ["내주식", "즐겨찾기", "트레이딩 주식"])

    private let headerStcokLabel: UILabel = {
        let label = UILabel()
        label.text = "주식명"

        return label
    }()

    private let headerChartLabel: UILabel = {
        let label = UILabel()
        label.text = "차트"

        return label
    }()

    private let headerPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "현재가"

        return label
    }()

    lazy var headerLabelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [headerStcokLabel, headerChartLabel, headerPriceLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal

        return stackView
    }()

    private var dataSource: UICollectionViewDiffableDataSource<Section, Stock>! = nil
    private var collectionView: UICollectionView! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.title = "main tab"
        configureHierarchy()
        configureDataSource()
        configureLayout()
    }
}

extension MainHomeTabControllerCollectionViewController {
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
//        config.headerMode = .supplementary
        return UICollectionViewCompositionalLayout.list(using: config)
    }
}

extension MainHomeTabControllerCollectionViewController {
    private func configureHierarchy() {
        view.backgroundColor = .white
        view.addSubview(containerStackView)
        view.addSubview(segmentedControl)
        view.addSubview(headerLabelStackView)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
        collectionView.delegate = self
    }

    /// - Tag: CellRegistration
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<CustomStcokListCellCollectionViewCell, Stock> { (cell, indexPath, item) in
            cell.updateWithItem(item)
            cell.accessories = [.disclosureIndicator()]
        }

        dataSource = UICollectionViewDiffableDataSource<Section, Stock>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: Stock) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }

        // initial data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Stock>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Stock.all)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    private func configureLayout() {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            containerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),

            refreshButton.trailingAnchor.constraint(equalTo: containerStackView.trailingAnchor),

            segmentedControl.topAnchor.constraint(equalTo: containerStackView.bottomAnchor, constant: 32),
            segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            segmentedControl.heightAnchor.constraint(equalToConstant: 20),

            headerLabelStackView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            headerLabelStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            headerLabelStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            headerLabelStackView.heightAnchor.constraint(equalToConstant: 20),

            collectionView.topAnchor.constraint(equalTo: headerLabelStackView.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension MainHomeTabControllerCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
