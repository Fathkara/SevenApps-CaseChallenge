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
    private var userList = [UserListModel]()
    
    //MARK: - Properties
    var viewModel: UserListViewModel?
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createUI()
        initDelegate()
        configureConstraints()
        Task {
           await viewModel?.load()
        }

    }
    
    //MARK: - Private Func
    
    private func createUI() {
        navigationItem.hidesBackButton = true
        let titleText = "Kullanıcı Listesi"
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: Font.custom(size: 20,fontWeight: .Bold)
        ]
        let attributedTitle = NSAttributedString(string: titleText, attributes: attributes)

        titleLabel.attributedText = attributedTitle
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
        userListTableView.register(UserListTableViewCell.self, forCellReuseIdentifier: UserListTableViewCell.Identifier.path.rawValue)
        let rightButton = UIBarButtonItem(image: UIImage(systemName: "suit.heart.fill"), style: .done, target: self, action: #selector(rightButtonTapped))
        navigationItem.rightBarButtonItem = rightButton
        view.addSubview(userListTableView)


    }
    
    private func initDelegate() {
        userListTableView.delegate = self
        userListTableView.dataSource = self
        viewModel?.delegate = self
    }
    
    
    @objc func rightButtonTapped(){
        self.show(UserListFavoriteBuilder.make(), sender: nil)
    }


}
extension UserListVC: UserListViewModelDelegate {
    func handlerOutput(output: UserListViewModelOutPut) {
        switch output {
        case.userList(let userList):
            self.userList = userList
            DispatchQueue.main.async {
                self.userListTableView.reloadData()
            }
        case .error(let error):
            print(error)
        }
    }
    
    
}

// MARK: UITableViewDelegate, UITableViewDataSource

extension UserListVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = userListTableView.dequeueReusableCell(withIdentifier: UserListTableViewCell.Identifier.path.rawValue) as? UserListTableViewCell else
        {
            return UITableViewCell()
        }
        
        let userListArray = userList[indexPath.row]
        cell.userName.text = userListArray.name
        cell.userEmail.text = userListArray.email
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height * 0.08
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var id: Int?
        id = userList[indexPath.row].id
        let vc = UserListDetailBuilder.make(id: id ?? 0)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

// MARK: Constraints

extension UserListVC {
    func configureConstraints() {
        userListTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(32)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

