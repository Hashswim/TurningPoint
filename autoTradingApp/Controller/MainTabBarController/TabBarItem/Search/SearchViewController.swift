//
//  searchViewController.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/05/22.
//

import UIKit

class SearchViewCustomCell: UITableViewCell {
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MySpecialColors.darkGray

        return view
    }()

    let stockLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func layout() {
        self.addSubview(containerView)
        containerView.addSubview(stockLabel)

        self.backgroundColor = MySpecialColors.red

        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 51),

            containerView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            containerView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 2),
            containerView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -2),
            containerView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),

            stockLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            stockLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 36),
            stockLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            stockLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
}

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
        searchController.searchBar.setValue("취소", forKey: "cancelButtonText")
        searchController.searchBar.searchTextField.backgroundColor = MySpecialColors.textGray
        //        searchController.searchBar.tintColor = MySpecialColors.bgColor
        //        searchController.searchBar.searchTextField.font =
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
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

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.isFiltering ? self.filteredArr.count : self.arr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SearchViewCustomCell()
        cell.backgroundColor = MySpecialColors.bgColor
        if self.isFiltering {
            cell.stockLabel.attributedText = NSMutableAttributedString().medium(string: self.filteredArr[indexPath.row], fontSize: 15)
        } else {
            cell.stockLabel.attributedText = NSMutableAttributedString().medium(string: self.arr[indexPath.row], fontSize: 15)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
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

