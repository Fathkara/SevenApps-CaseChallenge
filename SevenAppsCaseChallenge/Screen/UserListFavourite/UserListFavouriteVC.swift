//
//  UserListFavouriteVC.swift
//  SevenAppsCaseChallenge
//
//  Created by Fatih Kara on 30.01.2025.
//

import UIKit
import Lottie

class UserListFavouriteVC: UIViewController {
    
    //MARK: UI

   private let generalView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let favUserListTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UIScreen.main.bounds.width * 0.17
        tableView.register(UserListFavouriteTableViewCell.self, forCellReuseIdentifier: UserListFavouriteTableViewCell.Identifier.path.rawValue)
        return tableView
    }()
    
    private let animationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "empty")
        animationView.isHidden = true
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.play()
        return animationView
    }()
    
    //MARK: Properties
    private var favIsEmpty = true
    private var userList = [UserList]()
    var viewModel: UserListFavoriteViewModelProtocol?
    private let context = appDelegate.persistentContainer.viewContext
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDelegate()
        configure()
        configureConstraints()
        isEmpty()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        isEmpty()
        fetchData()
        favUserListTableView.reloadData()
    }
    
    
    private func initDelegate() {
        viewModel?.output = self
        favUserListTableView.delegate = self
        favUserListTableView.dataSource = self
    }
    
    private func configure(){
        view.backgroundColor = .white
        view.addSubview(generalView)
        view.addSubview(favUserListTableView)
        view.addSubview(animationView)
        navigationItem.hidesBackButton = true
        navigationItem.title = "FAVORITES USERLIST"
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : Font.custom(size: 16,fontWeight: .Bold)]
        let leftButton = UIBarButtonItem(image: UIImage(named: "back"), style: .done, target: self, action: #selector(leftButtonTapped))
        navigationItem.leftBarButtonItem = leftButton
    }
    
    private func fetchData(){
        viewModel?.fetchCoreData()
    }
    
    private func isEmpty(){
        if userList.isEmpty {
            favIsEmpty = true
            favUserListTableView.isHidden = true
            animationView.isHidden = false
        }else{
            favIsEmpty = false
            favUserListTableView.isHidden = false
            animationView.isHidden = true
        }
    }
    
    @objc func leftButtonTapped(){
        navigationController?.popViewController(animated: true)
    }

}

// MARK: UserListFavouriteOutput

extension UserListFavouriteVC: UserListFavoriteOutput {
    func favoriteUserList(data: [UserList]) {
        self.userList = data
        self.favUserListTableView.reloadData()
    }
}
//MARK: -Tableview
extension UserListFavouriteVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserListFavouriteTableViewCell.Identifier.path.rawValue) as? UserListFavouriteTableViewCell else
        {
            return UITableViewCell()
        }
        cell.saveUI(list: userList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * 0.08
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let alertAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, completion) in
            let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete this UserList?", preferredStyle: .alert)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
                let userList = self.userList[indexPath.row]
                self.viewModel?.deleteCoreData(list: userList)
                self.favUserListTableView.reloadData()
                self.fetchData()
                self.isEmpty()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
            completion(false)
        }
        return UISwipeActionsConfiguration(actions: [alertAction])
    }
}

//MARK: Constraints
extension UserListFavouriteVC {
    private func configureConstraints(){
        generalView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(0.001 * UIScreen.main.bounds.height)
        }
        favUserListTableView.snp.makeConstraints { make in
            make.top.equalTo(generalView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        animationView.snp.makeConstraints { make in
            make.centerY.centerX.equalTo(view)
            make.height.width.equalTo(UIScreen.main.bounds.width * 0.6)
        }
    }
}
