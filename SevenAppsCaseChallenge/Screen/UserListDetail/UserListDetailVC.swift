//
//  UserListDetailVC.swift
//  SevenAppsCaseChallenge
//
//  Created by Fatih Kara on 29.01.2025.
//

import UIKit

class UserListDetailVC: UIViewController {
    //MARK: - UI
    let userNameLabel = UILabel()
    let userEmailLabel = UILabel()
    let userPhoneLabel = UILabel()
    let userWebSiteLabel = UILabel()
    
    //MARK: - Properties
    var viewModel: UserListDetailViewModel?
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        initDelegate()
        configureConstraints()
        Task {
            await viewModel?.loadDetail()
        }


    }
    
    //MARK: - Private Func
    
    private func createUI() {
        view.backgroundColor = .white
        navigationItem.hidesBackButton = false
        view.addSubview(userNameLabel)
        view.addSubview(userEmailLabel)
        view.addSubview(userPhoneLabel)
        view.addSubview(userWebSiteLabel)
        userNameLabel.font = Font.custom(size: 18,fontWeight: .Bold)
        userEmailLabel.font = Font.custom(size: 18,fontWeight: .Bold)
        userPhoneLabel.font = Font.custom(size: 18,fontWeight: .Bold)
        userWebSiteLabel.font = Font.custom(size: 18,fontWeight: .Bold)
        
        let leftButton = UIBarButtonItem(image: UIImage(named: "back"), style: .done, target: self, action: #selector(leftButtonTapped))
        navigationItem.leftBarButtonItem = leftButton
        leftButton.tintColor = .black
 
    }
    
    private func initDelegate() {
        viewModel?.delegate = self
    }
    
    private func saveUI(userData: [UserListModel]) {
        for user in userData {
            navigationItem.title = user.name
            userNameLabel.text = "Name: \(user.name)"
            userPhoneLabel.text = "Phone: \(user.phone)"
            userEmailLabel.text = "Email: \(user.email)"
            userWebSiteLabel.text = "WebSite: \(user.website)"
        }
    }
    
    @objc func leftButtonTapped(){
        navigationController?.popViewController(animated: true)
    }

}

extension UserListDetailVC: UserListDetailViewModelDelegate {
    func handlerOutput(output: UserListDetailModelOutPut) {
        switch output {
        case.userList(let userList):
            self.saveUI(userData: userList)
        case .error(let error):
            print(error)
        }
    }
}

// MARK: Constraints

extension UserListDetailVC {
    func configureConstraints() {
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(32)
            make.left.equalToSuperview().offset(16)
        }
        
        userPhoneLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel).offset(64)
            make.left.equalToSuperview().offset(16)
        }
        
        userEmailLabel.snp.makeConstraints { make in
            make.top.equalTo(userPhoneLabel).offset(64)
            make.left.equalToSuperview().offset(16)
        }
        
        userWebSiteLabel.snp.makeConstraints { make in
            make.top.equalTo(userEmailLabel).offset(64)
            make.left.equalToSuperview().offset(16)
        }

    }
}
