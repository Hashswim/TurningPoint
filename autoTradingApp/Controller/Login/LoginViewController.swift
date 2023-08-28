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
//    let label: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "test"
//        label.textColor = .brown
//        return label
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = MySpecialColors.bgColor
        view.addSubview(loginView)
        addTapGesture()
        configureLayout()
        configureTextField()
        configureButton()
        setUpNaviBar()
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
        loginView.nameTextField.delegate = self
        loginView.appKeyTextField.delegate = self
        loginView.secretKeyTextField.delegate = self
    }

    func configureButton() {
        loginView.loginButton.addTarget(self, action: #selector(loginBtnAction), for: .touchUpInside)
        loginView.keyGuideButton.addTarget(self, action: #selector(guideButton), for: .touchUpInside)
    }

    func setUpNaviBar() {
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.topItem?.title = ""
    }

    @objc
    func loginBtnAction() {
        let name = loginView.nameTextField.text
        let appKey = loginView.appKeyTextField.text
        let secretKey = loginView.secretKeyTextField.text

        UserInfo.shared.name = name

        networkManager.getAccessToken(appKey: appKey!, secretKey: secretKey!, completion: { token in
            if let token = token {
                UserInfo.shared.accessToken = token

                let mainTabBarController = MainTabBarController()
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
            } else {
                self.loginView.errorLabel.isHidden = false
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

    func textFieldDidChangeSelection(_ textField: UITextField) {
        loginView.loginButton.isEnabled = (loginView.nameTextField.hasText) && (loginView.appKeyTextField.hasText) && (loginView.secretKeyTextField.hasText)
        if loginView.loginButton.isEnabled {
            loginView.loginButton.backgroundColor = .red
            loginView.loginButton.layer.borderWidth = 0
        } else {
            loginView.loginButton.backgroundColor = MySpecialColors.bgColor
            loginView.loginButton.layer.borderWidth = 1
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == loginView.nameTextField {
            if(loginView.nameTextField.text?.count)! + string.count > 7{
                return false
            }else{
                return true
            }
        } else {
            return true
        }
    }


    //    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    //        let maxLength = 7
    //        let currentString = (loginView.nameTextField.text ?? "") as NSString
    //        let newString = currentString.replacingCharacters(in: range, with: string)
    //
    //        return newString.count <= maxLength
    //    }
}
