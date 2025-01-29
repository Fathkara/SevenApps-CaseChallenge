//
//  ViewController.swift
//  SevenAppsCaseChallenge
//
//  Created by Fatih Kara on 29.01.2025.
//

import UIKit
import SnapKit

class UserListVC: UIViewController {

    //MARK: - UI
    private let userListTableView = UITableView()
    let titleLabel = UILabel()
    
    //MARK: - Properties
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createUI()
        initDelegate()
    }
    
    //MARK: - Private Func
    
    private func createUI() {
        navigationController?.navigationBar.tintColor = .white
        let titleText = "Kullanıcı Listesi"
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: Font.custom(size: 20,fontWeight: .Bold)
        ]
        let attributedTitle = NSAttributedString(string: titleText, attributes: attributes)

        titleLabel.attributedText = attributedTitle
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
        userListTableView.backgroundColor = .red
        view.addSubview(userListTableView)
        configureConstraints()
    }
    
    private func initDelegate() {
        userListTableView.delegate = self
        userListTableView.dataSource = self
    }


}

// MARK: UITableViewDelegate, UITableViewDataSource

extension UserListVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

// MARK: Constraints

extension UserListVC {
    func configureConstraints() {
        userListTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(64)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

