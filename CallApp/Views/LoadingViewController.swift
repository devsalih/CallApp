//
//  LoadingViewController.swift
//  CallApp
//
//  Created by devsalih on 4.04.2023.
//

import UIKit
import SnapKit

class LoadingViewController: UIViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to CallApp"
        label.font = UIFont.systemFont(ofSize: 36, weight: .light)
        label.textColor = .white
        return label
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .white
        indicator.startAnimating()
        return indicator
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(red: 8/255, green: 156/255, blue: 255/255, alpha: 1)
        
        view.addSubview(titleLabel)
        view.addSubview(activityIndicator)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalTo(view.center)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide.snp.center)
        }
    }
}
