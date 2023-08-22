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
    let networkManager = NetworkManager()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSMutableAttributedString()
            .bold(string: "이수림", fontSize: 28)
            .regular(string: "님", fontSize: 28)
        label.textColor = .white
        return label
    }()

    private let sunamtTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left

        label.textColor = .gray
        return label
    }()

    private let sunamtLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right

        label.textColor = .gray
        return label
    }()

    private let tdtsunikTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left

        label.textColor = .gray
        return label
    }()

    private let tdtsunikLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right

        label.textColor = .gray
        return label
    }()

    lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel])
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


        stackView.axis = .horizontal

        return stackView
    }()

    private var dataSource: UICollectionViewDiffableDataSource<Section, Stock>! = nil
    private var collectionView: UICollectionView! = nil

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

//        navigationItem.title = "main tab"

//        segmentedControl
        configureHierarchy()
        configureDataSource()
        setUpUI()
        self.networkManager.getUserAccount(completion: getUserAccount)

        testAPI()
    }


    func getUserAccount(sunamt: Double, tdtsunik: Double, ownedStoks: [ownedStock]) -> () {
        Stock.all = ownedStoks
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        sunamtLabel.attributedText = NSMutableAttributedString()
            .regular(string: numberFormatter.string(from: sunamt as NSNumber)!, fontSize: 12)
            .regular(string: " 원", fontSize: 12)
        tdtsunikLabel.attributedText = NSMutableAttributedString()
            .regular(string: numberFormatter.string(from: tdtsunik as NSNumber)!, fontSize: 12)
            .regular(string: " 원", fontSize: 12)

        var idx = 0
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [unowned self] timer in
            self.networkManager.getNowPrice(code: Stock.all[idx].code!, idx: idx, completion: getNowPrice)

            if idx+1 == Stock.all.count {
                timer.invalidate()
            }
            idx += 1
        }
    }

    func getNowPrice(name: String, code: String, idx: Int, price: Double, difference: Double, volume: Double, change: Double) -> () {
        Stock.all[idx].price = price
        Stock.all[idx].priceDifference = difference
        Stock.all[idx].volume = volume
        Stock.all[idx].change = change

        self.networkManager.getDateChart(code: code, idx: idx, completion: getDateChartData)
    }

    func getDateChartData(code: String, idx: Int, chartData: [DateChart]) -> () {
        Stock.all[idx].dateChartList = chartData
        self.networkManager.getLogo(code: code, idx: idx, completion: getLogoData)
    }

    func getLogoData(idx: Int, logo: UIImage) -> () {
        Stock.all[idx].logo = logo
        Stock.loaded.append(Stock.all[idx])

        var snapshot = dataSource.snapshot()
        snapshot.appendItems(Stock.loaded)
        self.dataSource?.apply(snapshot)
    }


    //DataStore 생성하면서 변경
    private func toggleIsFavorite(_ stock: Stock, _ indexPath: IndexPath) -> Bool {
        stock.isFavorite?.toggle()

        if stock.isFavorite == true {
            Stock.favorite.append(stock)
        } else {
            Stock.favorite.remove(at: indexPath.row)
        }

        var snapshot = NSDiffableDataSourceSnapshot<Section, Stock>()
        snapshot.appendSections([.main])

        if self.segmentedControl.selectedSegmentIndex == 0 {
            snapshot.appendItems(Stock.loaded)
        } else {
            snapshot.appendItems(Stock.favorite)
        }

        self.dataSource?.apply(snapshot)

        return stock.isFavorite!
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

    private func trailingSwipeActionsConfiguration(for indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let stock = dataSource.itemIdentifier(for: indexPath)
        else { return nil }

        let configuration = UISwipeActionsConfiguration(actions: [
            detailContextualAction(stock: stock as! ownedStock, indexPath: indexPath),
            favoriteContextualAction(stock: stock, indexPath: indexPath)
        ])
        configuration.performsFirstActionWithFullSwipe = false
        
        return configuration
    }

    private func detailContextualAction(stock: ownedStock, indexPath: IndexPath) -> UIContextualAction {
        let detailAction = UIContextualAction(style: .normal, title: title) { [weak self] _, _, completionHandler in
            guard let self = self else { return }

            let vc = DetailViewController()
            vc.stock = stock
            self.navigationController?.pushViewController(vc, animated: true)

            completionHandler(true)
        }
        detailAction.image = UIImage(systemName: "info.circle.fill")
        detailAction.backgroundColor = MySpecialColors.bgColor

        return detailAction
    }

    private func favoriteContextualAction(stock: Stock, indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: title) { [weak self] _, _, completionHandler in
            guard let self = self else { return }
            completionHandler(self.toggleIsFavorite(stock, indexPath))
        }
        let name = stock.isFavorite! ?  "heart.fill" : "heart"
        action.image = UIImage(systemName: name)
        action.backgroundColor = MySpecialColors.bgColor
        return action
    }
}

extension MainHomeTabController {
    private func configureHierarchy() {
        view.backgroundColor = .white
        view.addSubview(containerStackView)
        view.addSubview(sunamtTitleLabel)
        view.addSubview(sunamtLabel)
        view.addSubview(tdtsunikTitleLabel)
        view.addSubview(tdtsunikLabel)
        view.addSubview(segmentedControl)
        view.addSubview(headerLabelStackView)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
        collectionView.delegate = self
    }

    private func setUpUI() {
        view.backgroundColor = MySpecialColors.bgColor

        sunamtTitleLabel.attributedText = NSMutableAttributedString().regular(string: "순자산: ", fontSize: 12)
        tdtsunikTitleLabel.attributedText = NSMutableAttributedString().regular(string: "평가손익: ", fontSize: 12)

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
            containerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),

            sunamtTitleLabel.topAnchor.constraint(equalTo: containerStackView.topAnchor, constant: 8),
            sunamtTitleLabel.trailingAnchor.constraint(equalTo: sunamtLabel.leadingAnchor, constant: -2),
            sunamtTitleLabel.widthAnchor.constraint(equalToConstant: 52),
            sunamtTitleLabel.heightAnchor.constraint(equalToConstant: 16),

            sunamtLabel.topAnchor.constraint(equalTo: containerStackView.topAnchor, constant: 8),
            sunamtLabel.trailingAnchor.constraint(equalTo: containerStackView.trailingAnchor),
            sunamtLabel.widthAnchor.constraint(equalToConstant: 64),
            sunamtLabel.heightAnchor.constraint(equalToConstant: 16),

            tdtsunikTitleLabel.topAnchor.constraint(equalTo: sunamtLabel.bottomAnchor, constant: 2),
            tdtsunikTitleLabel.trailingAnchor.constraint(equalTo: tdtsunikLabel.leadingAnchor, constant: -2),
            tdtsunikTitleLabel.widthAnchor.constraint(equalToConstant: 52),
            tdtsunikTitleLabel.heightAnchor.constraint(equalToConstant: 16),

            tdtsunikLabel.topAnchor.constraint(equalTo: sunamtLabel.bottomAnchor, constant: 2),
            tdtsunikLabel.trailingAnchor.constraint(equalTo: containerStackView.trailingAnchor),
            tdtsunikLabel.widthAnchor.constraint(equalToConstant: 64),
            tdtsunikLabel.heightAnchor.constraint(equalToConstant: 16),

            segmentedControl.topAnchor.constraint(equalTo: containerStackView.bottomAnchor, constant: 32),
            segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            segmentedControl.heightAnchor.constraint(equalToConstant: 17),

            headerLabelStackView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            headerLabelStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerLabelStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            headerLabelStackView.heightAnchor.constraint(equalToConstant: 20),

            headerStcokLabel.leadingAnchor.constraint(equalTo: headerLabelStackView.leadingAnchor, constant: 18),
            headerStcokLabel.widthAnchor.constraint(equalToConstant: 33),

            headerChartLabel.leadingAnchor.constraint(equalTo: headerLabelStackView.leadingAnchor, constant: 196),
            headerChartLabel.widthAnchor.constraint(equalToConstant: 22),

            headerPriceLabel.leadingAnchor.constraint(equalTo: headerLabelStackView.leadingAnchor, constant: 304),
            headerPriceLabel.widthAnchor.constraint(equalToConstant: 33),

            collectionView.topAnchor.constraint(equalTo: headerLabelStackView.bottomAnchor, constant: 4),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
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
//        snapshot.appendItems(Stock.all)
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
        guard let stock = dataSource.itemIdentifier(for: indexPath)
        else { return }

        let vc = StockTradingViewController()
        vc.stock = stock
        self.navigationController?.pushViewController(vc, animated: true)
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

