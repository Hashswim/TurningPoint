//
//  MyPageViewController.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/05/22.
//

import UIKit

class MyPageViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    let profileButton: UIButton = {
        let btn = UIButton(type: .custom)

        return btn
    }()

    let profileImg = UIImage()
    let nameLabel = UILabel()
    let btnTableView = UITableView()
    var dataSource = CellDataModel.mockedData

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        profileButton.clipsToBounds = true
        profileButton.frame = CGRect(x: 0, y: 0, width: 112, height: 112)
        profileButton.layer.cornerRadius = 0.5 * profileButton.bounds.size.width
        profileButton.layer.masksToBounds = true

        profileButton.layer.borderWidth = 1

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureHierarchy()
        configureNavigation()
    }
    
    func configureUI() {
        self.title = "마이페이지"

        nameLabel.attributedText = NSMutableAttributedString().bold(string: UserInfo.shared.name!, fontSize: 25)
        nameLabel.textColor = .white
        nameLabel.textAlignment = .center

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        btnTableView.translatesAutoresizingMaskIntoConstraints = false

        profileButton.addTarget(self, action: #selector(imagePickerPressed), for: .touchUpInside)

        let user: [User] = UserCoreDataManager.shared.readUserEntity()
        profileButton.setBackgroundImage(UIImage(data: user[0].profileImage ?? Data()), for: .normal)

        CellDataModel.mockedData = [
            CellDataModel(title: "내 계좌확인", description: "추정 순자산: \(UserAccount.shared.sunamt!) \n실현손익: \(UserAccount.shared.dtsunik!)\n매입금액: \(UserAccount.shared.mamt!) \n추정D2예수금\(UserAccount.shared.sunamt1!) \n평가금액\(UserAccount.shared.tappamt!) \n평가손익\(UserAccount.shared.tdtsunik!)"),
            CellDataModel(title: "도움말", description: "트레이닝 서비스는 AI 모델을 보유한 주식을 소유하고 있을 때 가능합니다."),
            CellDataModel(title: "약관확인", description: "투자에 대한 책임은 본인에게 있습니다."),
            CellDataModel(title: "로그아웃", description: ""),
        ]

        btnTableView.register(ExpandableTableViewCell.self, forCellReuseIdentifier: ExpandableTableViewCell.reuseIdentifier)

        scrollView.backgroundColor = MySpecialColors.bgColor
        contentView.backgroundColor = MySpecialColors.bgColor

        btnTableView.dataSource = self
        btnTableView.delegate = self
        btnTableView.backgroundColor = .white
        btnTableView.tableFooterView = UIView() // Removes empty cell separators
        btnTableView.estimatedRowHeight = 80
        
        btnTableView.rowHeight = UITableView.automaticDimension
    }

    func configureNavigation() {
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .gray
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = MySpecialColors.bgColor
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: NotoSansFont.medium(size: 17)]

        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
    }

    func configureHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(profileButton)
        contentView.addSubview(nameLabel)
        contentView.addSubview(btnTableView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor),

            profileButton.widthAnchor.constraint(equalToConstant: 112),
            profileButton.heightAnchor.constraint(equalToConstant: 112),
            profileButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            profileButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 140),
            profileButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 60),

            nameLabel.topAnchor.constraint(equalTo: profileButton.bottomAnchor, constant: 30),
            nameLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            nameLabel.widthAnchor.constraint(equalToConstant: 73),
            nameLabel.heightAnchor.constraint(equalToConstant: 32),

            btnTableView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 80),
            btnTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            btnTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            btnTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    @objc
    func imagePickerPressed(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self

        self.present(picker, animated: true)
    }

}

extension MyPageViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExpandableTableViewCell.reuseIdentifier, for: indexPath) as? ExpandableTableViewCell else { return UITableViewCell() }
        cell.set(dataSource[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }

}

extension MyPageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataSource[indexPath.row].isExpanded.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)

        if indexPath.row == 3 {
            UserCoreDataManager.shared.delete()

            Stock.all = []
            Stock.favorite = []
            Stock.loaded = []
            Stock.traiding = []

            let vc = LoginViewController()
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(vc)
        }
    }
}

extension MyPageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        picker.dismiss(animated: true) {
            if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                self.profileButton.setBackgroundImage(img, for: .normal)
                UserCoreDataManager.shared.update(appKey: UserInfo.shared.appKey!, profileImage: img.pngData()!)

            } else {
                print("image nil")
            }
        }
    }
}
