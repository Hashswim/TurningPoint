//
//  LoginViewController.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/01/26.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {
    let networkManager = NetworkManager()

    let loginView = LoginView()
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "test"
        label.textColor = .brown
        return label
    }()

    let alert = UIAlertController(title: "로그인 에러", message: "형식을 확인해주세요", preferredStyle: .alert)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(loginView)
        addTapGesture()
        configureLayout()
        configureAlert()
        configureTextField()
        configureButton()
    }

    func configureLayout() {
        loginView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            loginView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }

    func configureAlert() {
        let errorAction = UIAlertAction(title: "확인", style: .default) { _ in
            print("로그인 에러")
        }
        alert.addAction(errorAction)
    }

    func configureTextField() {
        loginView.nameTextField.delegate = self
        loginView.appKeyTextField.delegate = self
        loginView.secretKeyTextField.delegate = self
    }

    func configureButton() {
        loginView.loginButton.addTarget(self, action: #selector(loginBtnAction), for: .touchUpInside)
        loginView.keyGuideButton.addTarget(self, action: #selector(guideButton), for: .touchUpInside)
    }

    @objc
    func loginBtnAction() {
//        let name = loginView.nameTextField.text
        let appKey = loginView.appKeyTextField.text
        let secretKey = loginView.secretKeyTextField.text

        networkManager.getAccessToken(appKey: appKey!, secretKey: secretKey!, completion: { token in
            if let token = token {
                UserInfo.shared.accessToken = token

                let mainTabBarController = MainTabBarController()
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
            } else {
//                self.present(self.alert, animated: false, completion: nil)
                return
            }
        })
    }

    @objc
    func guideButton() {
        let url = NSURL(string: "https://openapi.ebestsec.co.kr/howto-use")
        let guideView: SFSafariViewController = SFSafariViewController(url: url! as URL)
        self.present(guideView, animated: true, completion: nil)
    }

    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        view.addGestureRecognizer(tapGesture)
    }

    @objc
    private func hideKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        //check validate key format
        return true
    }
}
