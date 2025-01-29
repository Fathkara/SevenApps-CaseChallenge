//
//  UserListTableViewCell.swift
//  SevenAppsCaseChallenge
//
//  Created by Fatih Kara on 29.01.2025.
//

import UIKit

class UserListTableViewCell: UITableViewCell {
    //MARK: UI
    let userName = UILabel()
    let userEmail = UILabel()
    
    enum Identifier: String {
        case path = "Cell"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private Function
    
    private func configure(){
        contentView.addSubview(userName)
        contentView.addSubview(userEmail)
        userName.textAlignment = .left
        userName.font = Font.custom(size: 13,fontWeight: .Medium)
        userEmail.font = Font.custom(size: 13,fontWeight: .SemiBold)
        
        configureConstraints()
    }
    private func configureConstraints() {
        userName.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8)
            make.centerY.equalTo(contentView)
            make.width.equalTo(contentView.bounds.width * 0.5)
            make.height.equalTo(contentView.bounds.height * 0.6)
        }
        
        userEmail.snp.makeConstraints { make in
            make.left.equalTo(userName.snp.right).offset(8)
            make.centerY.equalTo(contentView)
            make.height.equalTo(contentView.bounds.height * 1.2)
            make.width.equalTo(contentView.bounds.width * 0.7)
        }
    }
    

}
