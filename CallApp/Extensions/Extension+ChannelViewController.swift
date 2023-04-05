//
//  Extension+ChannelViewController.swift
//  CallApp
//
//  Created by devsalih on 4.04.2023.
//

import UIKit
import SnapKit

extension ChannelViewController {
    func initViews() {
        view.backgroundColor = UIColor(red: 255/255, green: 241/255, blue: 214/255, alpha: 1)
        
        // MARK: - App Bar
        
        let appBar: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(red: 8/255, green: 156/255, blue: 253/255, alpha: 1)
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowOpacity = 0.5
            view.layer.shadowOffset = CGSize(width: 0, height: 4)
            view.layer.shadowRadius = 4
            return view
        }()
        
        let stack: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.alignment = .center
            stackView.spacing = 10
            return stackView
        }()
        
        let header: UILabel = {
            let label = UILabel()
            label.text = "Channel Name"
            label.font = UIFont.systemFont(ofSize: 18, weight: .light)
            label.textColor = .white
            return label
        }()
        
        let channel: UILabel = {
            let label = UILabel()
            label.text = "CallApp"
            label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
            label.textColor = .white
            return label
        }()
        
        let leaveButton: UIButton = {
            let button = UIButton(type: .custom)
            let image = UIImage(named: "leave")?.withRenderingMode(.alwaysTemplate)
            button.setImage(image, for: .normal)
            button.tintColor = .white
            button.addTarget(self, action: #selector(leaveButtonTapped), for: .touchUpInside)
            return button
        }()
        
        let body = UIView()
        
        view.addSubview(appBar)
        appBar.addSubview(stack)
        appBar.addSubview(leaveButton)
        stack.addArrangedSubview(header)
        stack.addArrangedSubview(channel)
        view.addSubview(body)
        
        appBar.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(-10)
            make.left.equalTo(view.snp.left).offset(-10)
            make.right.equalTo(view.snp.right).offset(10)
            make.bottom.equalTo(stack.snp.bottom).offset(20)
        }
        
        stack.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
        }
        
        leaveButton.snp.makeConstraints { make in
            make.right.equalTo(view.snp.right).offset(-20)
            make.centerY.equalTo(stack.snp.centerY)
        }
        
        body.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).offset(10)
            make.right.equalTo(view.snp.right).offset(-10)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.top.equalTo(appBar.snp.bottom).offset(14)
        }
        
        // MARK: - Receiver
        
        let receiverArea: UIView = {
            let view = UIView()
            view.backgroundColor = .tertiarySystemFill
            view.layer.cornerRadius = 10
            return view
        }()
        
        let receiverTitle: UILabel = {
            let label = UILabel()
            label.text = "Their Speech"
            label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            return label
        }()
        
        receiverLabel.font = UIFont.systemFont(ofSize: 18, weight: .light)
        receiverLabel.numberOfLines = 0
        receiverLabel.lineBreakMode = .byTruncatingHead
        receiverLabel.textAlignment = .center
        
        view.addSubview(receiverArea)
        receiverArea.addSubview(receiverTitle)
        receiverArea.addSubview(receiverLabel)
        
        receiverArea.snp.makeConstraints { make in
            make.width.equalTo(body.snp.width)
            make.height.equalTo(body.snp.height).multipliedBy(0.5).offset(-5)
            make.top.equalTo(body.snp.top)
            make.centerX.equalTo(body.snp.centerX)
        }
        
        receiverTitle.snp.makeConstraints { make in
            make.top.equalTo(receiverArea.snp.top).offset(10)
            make.centerX.equalTo(receiverArea.snp.centerX)
            make.height.equalTo(30)
        }
        
        receiverLabel.snp.makeConstraints { make in
            make.top.equalTo(receiverTitle.snp.bottom).offset(50)
            make.left.equalTo(receiverArea.snp.left).offset(50)
            make.right.equalTo(receiverArea.snp.right).offset(-50)
            make.bottom.equalTo(receiverArea.snp.bottom).offset(-50)
        }
        
        // MARK: - Sender
        
        let senderArea: UIView = {
            let view = UIView()
            view.backgroundColor = .tertiarySystemFill
            view.layer.cornerRadius = 10
            return view
        }()
        
        let senderTitle: UILabel = {
            let label = UILabel()
            label.text = "Your Speech"
            label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            return label
        }()
        
        senderLabel.font = UIFont.systemFont(ofSize: 18, weight: .light)
        senderLabel.numberOfLines = 0
        senderLabel.lineBreakMode = .byTruncatingHead
        senderLabel.textAlignment = .center
        
        view.addSubview(senderArea)
        senderArea.addSubview(senderTitle)
        senderArea.addSubview(senderLabel)
        
        senderArea.snp.makeConstraints { make in
            make.width.equalTo(body.snp.width)
            make.height.equalTo(body.snp.height).multipliedBy(0.5).offset(-5)
            make.bottom.equalTo(body.snp.bottom)
            make.centerX.equalTo(body.snp.centerX)
        }
        
        senderTitle.snp.makeConstraints { make in
            make.top.equalTo(senderArea.snp.top).offset(10)
            make.centerX.equalTo(senderArea.snp.centerX)
            make.height.equalTo(30)
        }
        
        senderLabel.snp.makeConstraints { make in
            make.top.equalTo(senderTitle.snp.bottom).offset(50)
            make.left.equalTo(senderArea.snp.left).offset(50)
            make.right.equalTo(senderArea.snp.right).offset(-50)
            make.bottom.equalTo(senderArea.snp.bottom).offset(-50)
        }
    }
    
    @objc func leaveButtonTapped() { dismiss(animated: true) }
}
