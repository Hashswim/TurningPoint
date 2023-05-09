//
//  LoginViewController.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/01/26.
//

import UIKit


class LoginViewController: UIViewController {

    let loginView = LoginView()
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "test"
        label.textColor = .brown
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(loginView)
        addTapGesture()
        configureLayout()
        configureTextField()
        configureLoginButton()
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

    func configureTextField() {
        loginView.idTextField.delegate = self
        loginView.passwordTextField.delegate = self
    }

    func configureLoginButton() {
        loginView.loginButton.addTarget(self, action: #selector(loginBtnAction), for: .touchUpInside)
    }

    @objc
    func loginBtnAction() {
        let mainTabBarController = MainTabBarController()
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
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
        //check validate e-mail format
        return true
    }
}
