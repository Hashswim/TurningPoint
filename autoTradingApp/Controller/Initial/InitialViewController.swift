//
//  ViewController.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/01/26.
//

import UIKit

class InitialViewController: UIViewController {

    var guideCollectionView: UICollectionView!

    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()

        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.white.withAlphaComponent(0.3)
        pageControl.isEnabled = false

        return pageControl
    }()

    lazy var loginButton: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(loginBtnAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = MySpecialColors.tabBarTint
        btn.setAttributedTitle(NSMutableAttributedString().bold(string: "시작하기", fontSize: 16), for: .normal)
        btn.setTitleColor(.white, for: .normal)

        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true

        return btn
    }()

    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fillEqually

        return stackView
    }()

    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        return stackView
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()

        let amplifyManager = AmplifyManager()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @objc
    func loginBtnAction() {
        let loginViewController = LoginViewController()
        navigationController?.pushViewController(loginViewController, animated: true)
    }

//    @objc
//    func signUpBtnAction() {
//        let signUpViewController = SignUpGuideViewController()
//        navigationController?.pushViewController(signUpViewController, animated: true)
//    }
}

extension InitialViewController {
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
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        section.visibleItemsInvalidationHandler = {(item, offset, env) in
            let index = Int((offset.x / env.container.contentSize.width))
//            print(">>>> \(index)")
            self.pageControl.currentPage = index
        }

        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        let layout = UICollectionViewCompositionalLayout(section: section, configuration: configuration)

        return layout
    }
}

extension InitialViewController {
    private func configureHierarchy() {
        guideCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        guideCollectionView.register(GuideCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        guideCollectionView.delegate = self
        guideCollectionView.dataSource = self

        guideCollectionView.isScrollEnabled = false

        buttonStackView.addArrangedSubview(loginButton)

        containerStackView.addArrangedSubview(guideCollectionView)
        containerStackView.addArrangedSubview(pageControl)
        containerStackView.addArrangedSubview(buttonStackView)

        view.addSubview(containerStackView)
    }

    private func configureLayout() {
        view.backgroundColor = UIColor(hex: "#181C26")
        guideCollectionView.backgroundColor = UIColor(hex: "#181C26")

        NSLayoutConstraint.activate([
            guideCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            guideCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            guideCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            guideCollectionView.heightAnchor.constraint(equalToConstant: 550),

            pageControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pageControl.topAnchor.constraint(equalTo: guideCollectionView.bottomAnchor),
            pageControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            buttonStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 22),
            buttonStackView.topAnchor.constraint(equalTo: pageControl.bottomAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -22),
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            buttonStackView.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}

extension InitialViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? GuideCollectionViewCell else {
            return UICollectionViewCell()
        }
        let constant = GuideConstant()
        let textArr = GuideConstant.guideText

        cell.configureCell(test: textArr[indexPath.row], img: UIImage(named: "guide_img\(indexPath.row)")!)
        cell.backgroundColor = .systemGray
        return cell
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let page = Int(targetContentOffset.pointee.x / scrollView.frame.width)
        self.pageControl.currentPage = page
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.bounds.size.width
        let x = scrollView.contentOffset.x + (width/2)

        let newPage = Int(x/width)
        if pageControl.currentPage != newPage {
            pageControl.currentPage = newPage
        }
    }
}


