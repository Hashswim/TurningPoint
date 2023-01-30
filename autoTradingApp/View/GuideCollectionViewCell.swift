//
//  GuideCollectionViewCell.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/01/26.
//

import UIKit

class GuideCollectionViewCell: UICollectionViewCell {
    //    let guideIMGView: UIImageView = {
    //        var imgView = UIImageView()
    //
    //        return imgView
    //    }()
    let testLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureHierarchy()
//        self.configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init")
    }

    func configureHierarchy() {
        self.contentView.backgroundColor = .systemGray
        //        self.contentView.addSubview(guideIMGView)
        self.addSubview(testLabel)
    }

    func configureCell(test: String) {
        self.testLabel.text = test
    }
}
