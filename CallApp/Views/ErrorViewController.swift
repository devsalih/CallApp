//
//  ErrorViewController.swift
//  CallApp
//
//  Created by devsalih on 4.04.2023.
//

import UIKit

class ErrorViewController: UIViewController {

    let error: Error!
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 36, weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    init(error: Error) {
        self.error = error
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 200/255, green: 30/255, blue: 30/255, alpha: 1)
        
        errorLabel.text = error.localizedDescription
        view.addSubview(errorLabel)
        
        errorLabel.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.center.equalToSuperview()
        }
    }

}
