//
//  searchViewController.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/05/22.
//

import UIKit

class SearchViewController: UIViewController {

    private let tableView = UITableView()

    var nameArr = [""]
    var codeArr = [""]

    var filteredArr: [String] = []

    var isFiltering: Bool {
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
        return isActive && isSearchBarHasText
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpSearchBar()
        configureUI()
        setUpTableView()

//        let networkManager = NetworkManager()
//        networkManager.getTopTradingVolume(completion: configureStockList)
//        configureLayout()

        let amplifyManager = AmplifyManager()
        async  {
            let (codeArr, nameArr) = try await amplifyManager.postGetAllTrainedList()
            configureStockList(nameList: nameArr, codeList:codeArr)
            configureLayout()
        }
    }

    func setUpSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)

        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search Stock"
        searchController.searchBar.setValue("취소", forKey: "cancelButtonText")
//        searchController.title

        searchController.searchBar.searchTextField.backgroundColor = MySpecialColors.textGray
        //        searchController.searchBar.tintColor = MySpecialColors.bgColor
        //        searchController.searchBar.searchTextField.font =
        self.navigationItem.title = "AI 모델 보유종목"
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: NotoSansFont.medium(size: 17)]
        appearance.backgroundColor = MySpecialColors.bgColor

        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance

        searchController.searchBar.tintColor = .white
    }

    func setUpTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self

        tableView.separatorStyle = .none
        tableView.backgroundColor = MySpecialColors.bgColor
    }

    func configureUI() {
        view.addSubview(tableView)
        view.backgroundColor = MySpecialColors.bgColor
    }

    func configureLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    func configureStockList(nameList: [String], codeList: [String]) -> () {
        nameArr = nameList
        codeArr = codeList

        self.tableView.reloadData()
    }

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.isFiltering ? self.filteredArr.count : self.nameArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SearchViewCustomCell()
        cell.backgroundColor = MySpecialColors.bgColor
        if self.isFiltering {
            cell.stockLabel.attributedText = NSMutableAttributedString().medium(string: self.filteredArr[indexPath.row], fontSize: 15)
        } else {
            cell.stockLabel.attributedText = NSMutableAttributedString().medium(string: self.nameArr[indexPath.row], fontSize: 15)
        }

        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let code = codeArr[indexPath.row]
        let vc = TradableViewController()

        vc.shcode = code
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        self.filteredArr = self.nameArr.filter { $0.localizedCaseInsensitiveContains(text) }

        self.tableView.reloadData()
    }
}

