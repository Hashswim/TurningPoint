//
//  searchViewController.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/05/22.
//

import UIKit

class SearchViewController: UIViewController {

    private let tableView = UITableView()

    var arr = ["Zedd", "Alan Walker", "David Guetta", "Avicii", "Marshmello", "Steve Aoki", "R3HAB", "Armin van Buuren", "Skrillex", "Illenium", "The Chainsmokers", "Don Diablo", "Afrojack", "Tiesto", "KSHMR", "DJ Snake", "Kygo", "Galantis", "Major Lazer", "Vicetone"
    ]

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
        setUpTableView()
        configureUI()
        configureLayout()
    }

    func setUpSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)

        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search Stock"
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
    }

    func setUpTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    func configureUI() {
        view.addSubview(tableView)
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

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.isFiltering ? self.filteredArr.count : self.arr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if self.isFiltering {
            cell.textLabel?.text = self.filteredArr[indexPath.row]
        } else {
            cell.textLabel?.text = self.arr[indexPath.row]
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ChartViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        self.filteredArr = self.arr.filter { $0.localizedCaseInsensitiveContains(text) }

        self.tableView.reloadData()
    }

}

