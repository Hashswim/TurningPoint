//
//  SignUpViewController.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/03/05.
//

import UIKit

class SignUpGuideViewController: UIViewController {

    private let signUpGuideView = SignUpGuideView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(signUpGuideView)
        configureLayout()
        // Do any additional setup after loading the view.
    }

    func configureLayout() {
        signUpGuideView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signUpGuideView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            signUpGuideView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            signUpGuideView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            signUpGuideView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }

}
