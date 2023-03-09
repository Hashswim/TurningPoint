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

    private var dataSource: UICollectionViewDiffableDataSource<Section, Stock>! = nil
    private var collectionView: UICollectionView! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "main tab"
        configureHierarchy()
        configureDataSource()
    }
}

extension MainHomeTabControllerCollectionViewController {
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
}

extension MainHomeTabControllerCollectionViewController {
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
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
}

extension MainHomeTabControllerCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
