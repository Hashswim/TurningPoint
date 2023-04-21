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
        label.numberOfLines = 2
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
        registerTimer()
        testAPI()
    }

    //DataStore 생성하면서 변경
    private func toggleIsFavorite(_ stock: Stock) -> Bool {
        var stockToUpdate = stock
        stockToUpdate.isFavorite?.toggle()
//        return dataStore.update(recipeToUpdate) != nil
        return true
    }

    private func testAPI() {
        let manager = NetworkManager()

        manager.getStockAPITest { stock in
            DispatchQueue.main.sync {
                dump(stock)
            }
        }
    }
}


extension MainHomeTabControllerCollectionViewController {
    private func createLayout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        
        config.trailingSwipeActionsConfigurationProvider = { [weak self] indexPath in
            return self?.trailingSwipeActionsConfiguration(for: indexPath)
        }
        
        return UICollectionViewCompositionalLayout.list(using: config)
    }

    //Stock 대신 DataStore를 통해 저장해놓을 class 필요
    private func trailingSwipeActionsConfiguration(for indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let stock = dataSource.itemIdentifier(for: indexPath)
        else { return nil }

        let configuration = UISwipeActionsConfiguration(actions: [
            detailContextualAction(stock: stock),
            favoriteContextualAction(stock: stock)
        ])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }

    private func detailContextualAction(stock: Stock) -> UIContextualAction {
        let detailAction = UIContextualAction(style: .normal, title: "Detail") { [weak self] _, _, completionHandler in
            guard let self = self else { return }

            let vc = DetailViewController()
            self.navigationController?.pushViewController(vc, animated: true)

            completionHandler(true)
        }
        detailAction.image = UIImage(systemName: "info.circle.fill")
        return detailAction
    }

    private func favoriteContextualAction(stock: Stock) -> UIContextualAction {
        let title = stock.isFavorite! ? "Remove from Favorites" : "Add to Favorites"
        let action = UIContextualAction(style: .normal, title: title) { [weak self] _, _, completionHandler in
            guard let self = self else { return }
            completionHandler(self.toggleIsFavorite(stock))
        }
        let name = stock.isFavorite! ? "heart" : "heart.fill"
        action.image = UIImage(systemName: name)
        return action
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

    private func registerTimer() {
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updatetime), userInfo: nil, repeats: true)
    }

    @objc
    func updatetime() {
        let formatter = DateFormatter() // 특정 포맷으로 날짜를 보여주기 위한 변수 선언
        formatter.dateFormat = "yyyy-MM-dd \nHH:mm:ss" // 날짜 포맷 지정
        timeLabel.text = formatter.string(from: Date()) // 현재 시간 라벨에 지정한 날짜 포맷으로 입력
    }
}

extension MainHomeTabControllerCollectionViewController {
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
        print(indexPath.item)

        let vc = StockTradingViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }

}
