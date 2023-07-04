//
//  StrategyTableViewTableViewController.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/07/03.
//

import UIKit

class StrategyTableView: UITableView {
    override var intrinsicContentSize: CGSize {
            self.layoutIfNeeded()
            return self.contentSize
        }
    override var contentSize: CGSize {
            didSet {
                self.invalidateIntrinsicContentSize()
            }
        }
    override func reloadData() {
            super.reloadData()
            self.invalidateIntrinsicContentSize()
        }

}
