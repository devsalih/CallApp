//
//  LoginViewController.swift
//  CallApp
//
//  Created by devsalih on 4.04.2023.
//

import UIKit

class LoginViewController: UIViewController {
    let firebase = FirebaseService()
    
    var isLogin = true {
        didSet {
            let attributedTitle = NSMutableAttributedString(string: isLogin ? "Don't have an account? " : "Already have an account? ",
                                                            attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                                                                         NSAttributedString.Key.foregroundColor: UIColor.white])
            attributedTitle.append(NSAttributedString(string: isLogin ? "Sign Up" : "Login",
                                                      attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .heavy),
                                                                   NSAttributedString.Key.foregroundColor: UIColor.white]))
            dontHaveAccountButton.setAttributedTitle(attributedTitle, for: .normal)
            titleLabel.text = isLogin ? "Welcome to CallApp" : "Create an account"
            loginButton.setTitle(isLogin ? "Login" : "Sign Up", for: .normal)
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to CallApp"
        label.font = UIFont.systemFont(ofSize: 36, weight: .light)
        label.textColor = .white
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 255/255, green: 181/255, blue: 46/255, alpha: 1)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .black)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white])
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .heavy), NSAttributedString.Key.foregroundColor: UIColor.white]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(dontHaveAccountButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() { view.endEditing(true) }
    
    private func initViews() {
        view.backgroundColor = UIColor(red: 8/255, green: 156/255, blue: 255/255, alpha: 1)
        
        view.addSubview(titleLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(errorLabel)
        view.addSubview(dontHaveAccountButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalTo(view.center)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.equalTo(view.center)
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.centerX.equalTo(view.center)
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.centerX.equalTo(view.center)
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(20)
            make.centerX.equalTo(view.center)
            make.width.equalTo(300)
        }
    
        dontHaveAccountButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-20)
            make.centerX.equalTo(view.center)
        }
    }
    
    @objc private func loginButtonTapped() {
        let email = emailTextField.text ?? ""
        let pass = passwordTextField.text ?? ""
        
        if isLogin {
            firebase.login(email: email, password: pass) { result in
                switch result {
                case .success(_): break
                case .failure(let error): self.errorLabel.text = error.localizedDescription
                }
            }
        } else {
            firebase.createUser(email: email, password: pass) { result in
                switch result {
                case .success(_): break
                case .failure(let error): self.errorLabel.text = error.localizedDescription
                }
            }
        }
    }
    
    @objc private func dontHaveAccountButtonTapped() { isLogin.toggle() }
}
