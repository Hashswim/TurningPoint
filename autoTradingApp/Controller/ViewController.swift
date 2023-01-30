//
//  ViewController.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/01/26.
//

import UIKit

class ViewController: UIViewController {
    let loginViewController = LoginViewController()

    private let guideLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.text = "너도 주식 할 수 있어 \r\n간단하게 터포 !"
        label.textColor = .systemGray
        return label
    }()

    var guideCollectionView: UICollectionView!

    private let loginButton: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(loginBtnAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("로그인", for: .normal)

        return btn
    }()

    private let signUpButton: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(loginBtnAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("회원가입", for: .normal)

        return btn
    }()

    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fillEqually

        return stackView
    }()

    private let appleLoginButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("이미 계정이 있으신가요? Apple 계정 연동하기", for: .normal)

        return btn
    }()

    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        return stackView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
    }

    @objc
    func loginBtnAction() {
        navigationController?.pushViewController(loginViewController, animated: true)
    }

    @objc
    func signUpBtnAction() {
        navigationController?.pushViewController(loginViewController, animated: true)
    }
}

extension ViewController {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        let layout = UICollectionViewCompositionalLayout(section: section, configuration: configuration)

        return layout
    }
}



extension ViewController {
    private func configureHierarchy() {
        guideCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        guideCollectionView.register(GuideCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        guideCollectionView.delegate = self
        guideCollectionView.dataSource = self

        guideCollectionView.isScrollEnabled = false

        buttonStackView.addArrangedSubview(loginButton)
        buttonStackView.addArrangedSubview(signUpButton)

        containerStackView.addArrangedSubview(guideLabel)
        containerStackView.addArrangedSubview(guideCollectionView)
        containerStackView.addArrangedSubview(buttonStackView)
        containerStackView.addArrangedSubview(appleLoginButton)

        view.addSubview(containerStackView)
    }

    private func configureLayout() {
        NSLayoutConstraint.activate([
            guideLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            guideLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            guideLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            guideLabel.heightAnchor.constraint(equalToConstant: 84),

            guideCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            guideCollectionView.topAnchor.constraint(equalTo: guideLabel.bottomAnchor),
            guideCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            guideCollectionView.heightAnchor.constraint(equalToConstant: 300),

            buttonStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            buttonStackView.topAnchor.constraint(equalTo: guideCollectionView.bottomAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            buttonStackView.heightAnchor.constraint(equalToConstant: 80),

            appleLoginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            appleLoginButton.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor),
            appleLoginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            appleLoginButton.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? GuideCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(test: "1")
        cell.backgroundColor = .systemGray
        return cell
    }
}


