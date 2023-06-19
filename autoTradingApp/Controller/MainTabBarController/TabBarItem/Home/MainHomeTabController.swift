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

class MainHomeTabController: UIViewController {

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSMutableAttributedString()
            .bold(string: "이수림", fontSize: 28)
            .regular(string: "님", fontSize: 28)
        label.textColor = .white
        return label
    }()

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 10)
        label.textColor = .white

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

    private let segmentedControl = mainTabSegmentedControl(items: ["내 주식", "관심주식", "트레이딩 주식"])

    private let headerStcokLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSMutableAttributedString()
            .regular(string: "종목명", fontSize: 12)
        label.textColor = .gray
        return label
    }()

    private let headerChartLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSMutableAttributedString()
            .regular(string: "차트", fontSize: 12)
        label.textColor = .gray

        return label
    }()

    private let headerPriceLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSMutableAttributedString()
            .regular(string: "현재가", fontSize: 12)
        label.textColor = .gray

        return label
    }()

    lazy var headerLabelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [headerStcokLabel, headerChartLabel, headerPriceLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = MySpecialColors.darkGray

//        stackView.layoutMargins = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        stackView.setCustomSpacing(0, after: headerStcokLabel)
        stackView.setCustomSpacing(40, after: headerChartLabel)

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
        setUpUI()
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


extension MainHomeTabController {
    private func createLayout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        config.backgroundColor = MySpecialColors.bgColor

        config.trailingSwipeActionsConfigurationProvider = { [weak self] indexPath in
            return self?.trailingSwipeActionsConfiguration(for: indexPath)
        }

        config.itemSeparatorHandler = { (indexPath, sectionSeparatorConfiguration) in
            var configuration = sectionSeparatorConfiguration

            configuration.bottomSeparatorInsets = .init(top: 4, leading: 0, bottom: 0, trailing: 0)
            configuration.color = MySpecialColors.bgColor

            return configuration
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
        let detailAction = UIContextualAction(style: .normal, title: title) { [weak self] _, _, completionHandler in
            guard let self = self else { return }

            let vc = DetailViewController()
            self.navigationController?.pushViewController(vc, animated: true)

            completionHandler(true)
        }
        detailAction.image = UIImage(systemName: "info.circle.fill")
        detailAction.backgroundColor = MySpecialColors.darkGray
        return detailAction
    }

    // inout keyword 제거 후 stocks 저장하는 객체에 접근 필요
    private func favoriteContextualAction(stock: Stock) -> UIContextualAction {
//        let title = stock.isFavorite! ? "Remove from Favorites" : "Add to Favorites"
        let action = UIContextualAction(style: .normal, title: title) { [weak self] _, _, completionHandler in
            guard let self = self else { return }
            completionHandler(self.toggleIsFavorite(stock))
        }
        let name = stock.isFavorite! ? "heart" : "heart.fill"
        print(name)
        action.image = UIImage(systemName: name)
        action.backgroundColor = MySpecialColors.darkGray
        return action
    }
}

extension MainHomeTabController {
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

    private func setUpUI() {
        view.backgroundColor = MySpecialColors.bgColor

        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: NotoSansFont.bold(size: 17), NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: NotoSansFont.bold(size: 17),NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)

        segmentedControl.setWidth(72, forSegmentAt: 0)
        segmentedControl.setWidth(72, forSegmentAt: 1)
        segmentedControl.setWidth(120, forSegmentAt: 2)


        collectionView.backgroundColor = MySpecialColors.bgColor

        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)

        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            containerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),

            refreshButton.trailingAnchor.constraint(equalTo: containerStackView.trailingAnchor),

            segmentedControl.topAnchor.constraint(equalTo: containerStackView.bottomAnchor, constant: 32),
            segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            segmentedControl.heightAnchor.constraint(equalToConstant: 17),

            headerLabelStackView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            headerLabelStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerLabelStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            headerLabelStackView.heightAnchor.constraint(equalToConstant: 20),

            collectionView.topAnchor.constraint(equalTo: headerLabelStackView.bottomAnchor, constant: 4),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
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

extension MainHomeTabController {
    /// - Tag: CellRegistration
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<CustomStcokListCellCollectionViewCell, Stock> { (cell, indexPath, item) in
            cell.updateWithItem(item)
            cell.accessories = []
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

    @objc
    func segmentChanged(_ sender: UISegmentedControl) {
        switch self.segmentedControl.selectedSegmentIndex {
            //기존 snapshot에서 빼는 방식으로 변경?
        case 0:
            var snapshot = NSDiffableDataSourceSnapshot<Section, Stock>()
            snapshot.appendSections([.main])
            snapshot.appendItems(Stock.all)

            self.dataSource?.apply(snapshot)
        case 1:
            var snapshot = NSDiffableDataSourceSnapshot<Section, Stock>()
            snapshot.appendSections([.main])
            snapshot.appendItems(Stock.favorite)

            self.dataSource?.apply(snapshot)
        case 2:
            var snapshot = NSDiffableDataSourceSnapshot<Section, Stock>()
            snapshot.appendSections([.main])
            snapshot.appendItems(Stock.traiding)

            self.dataSource?.apply(snapshot)
        default:
            return
        }
    }
}

extension MainHomeTabController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)

        let vc = DetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

