//
//  MenuViewController.swift
//  CallApp
//
//  Created by devsalih on 4.04.2023.
//

import UIKit

class MenuViewController: UIViewController {
    let firebase = FirebaseService()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "CallApp"
        label.font = UIFont.systemFont(ofSize: 36, weight: .light)
        label.textColor = .white
        return label
    }()
    
    private let joinButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Join Channel", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 255/255, green: 181/255, blue: 46/255, alpha: 1)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .black)
        button.addTarget(self, action: #selector(joinButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 200/255, green: 30/255, blue: 30/255, alpha: 1)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .black)
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let column: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    private func initViews() {
        view.backgroundColor = UIColor(red: 255/255, green: 241/255, blue: 214/255, alpha: 1)
        
        view.addSubview(column)
        view.addSubview(titleLabel)
        view.addSubview(logoutButton)
        
        column.addArrangedSubview(logoImageView)
        column.addArrangedSubview(joinButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        column.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide.snp.center)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(270)
        }
        
        joinButton.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(logoImageView.snp.bottom).offset(-20)
            make.centerX.equalTo(view.center)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.centerX.equalTo(view.center)
            make.width.equalTo(view.snp.width).offset(-40)
            make.height.equalTo(50)
        }
    }
    
    @objc private func joinButtonTapped() {
        let vc = ChannelViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc private func logoutButtonTapped() {
        print("logout")
        try? firebase.logout()
    }
}
