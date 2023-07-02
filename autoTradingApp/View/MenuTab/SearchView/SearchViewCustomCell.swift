//
//  SearchViewCell.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/07/02.
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
