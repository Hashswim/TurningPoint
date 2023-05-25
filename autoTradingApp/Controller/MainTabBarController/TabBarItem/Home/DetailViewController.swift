//
//  DetailViewController.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/04/11.
//

import UIKit

class DetailViewController: UIViewController {

    private let stockNameLabel: UILabel = {
        let label = UILabel()

        return label
    }()

    private let stockPriceLabel: UILabel = {
        let label = UILabel()

        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
