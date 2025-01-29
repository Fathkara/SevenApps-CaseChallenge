//
//  UserListDetailVC.swift
//  SevenAppsCaseChallenge
//
//  Created by Fatih Kara on 29.01.2025.
//

import UIKit
import Lottie
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class UserListDetailVC: UIViewController {
    //MARK: - UI
    let userNameLabel = UILabel()
    let userEmailLabel = UILabel()
    let userPhoneLabel = UILabel()
    let userWebSiteLabel = UILabel()
    
    let addToFav: UIButton = {
        let button = UIButton()
        button.setTitle("Add To Favorites", for: .normal)
        button.titleLabel!.font = Font.custom(size: 15,fontWeight: .SemiBold)
        button.backgroundColor = .black
        button.layer.cornerRadius = 20
        return button
    }()
    
    let animationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "success")
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        return animationView
    }()

    
    //MARK: - Properties
    var viewModel: UserListDetailViewModel?
    var userFav: UserListModel? = nil
    
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
        view.addSubview(addToFav)
        view.addSubview(animationView)
        userNameLabel.font = Font.custom(size: 18,fontWeight: .Bold)
        userEmailLabel.font = Font.custom(size: 18,fontWeight: .Bold)
        userPhoneLabel.font = Font.custom(size: 18,fontWeight: .Bold)
        userWebSiteLabel.font = Font.custom(size: 18,fontWeight: .Bold)
        
        let leftButton = UIBarButtonItem(image: UIImage(named: "back"), style: .done, target: self, action: #selector(leftButtonTapped))
        navigationItem.leftBarButtonItem = leftButton
        leftButton.tintColor = .black
        addToFav.addTarget(self, action: #selector(didTapFavButton), for: .touchUpInside)
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
    
    @objc func didTapFavButton(){
        if let userDetail = userFav {
            viewModel?.addCoreData(data: userDetail)
        }
        animationView.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [self] in
            animationView.stop()
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
            userFav = userList.first
            
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
        
        addToFav.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.width.equalTo(UIScreen.main.bounds.width * 0.5)
            make.centerX.equalTo(view)
        }
        animationView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(view)
            make.height.width.equalTo(UIScreen.main.bounds.width * 0.3)
        }

    }
}
