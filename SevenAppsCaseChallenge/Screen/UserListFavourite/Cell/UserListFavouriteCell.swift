//
//  UserListFavouriteCell.swift
//  SevenAppsCaseChallenge
//
//  Created by Fatih Kara on 30.01.2025.
//

import UIKit
class UserListFavouriteTableViewCell: UITableViewCell {
    
    //MARK: UI
    
    let userName = UILabel()
    let userEmail = UILabel()

    enum Identifier: String {
        case path = "cell"
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private Function
    
    func saveUI(list: UserList){
        userName.text = list.name
        userEmail.text = list.email

    }
    
    private func configure() {
        contentView.addSubview(userName)
        contentView.addSubview(userEmail)
        userName.textAlignment = .left
    }
}

//MARK: Constraints

extension UserListFavouriteTableViewCell{
    private func configureConstraints(){
        userName.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(15)
            make.bottom.equalTo(contentView.snp.bottom).offset(-15)
            make.left.equalTo(contentView).offset(8)
        }
        userEmail.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(userName.snp.right).offset(24)
        }
    }
}
