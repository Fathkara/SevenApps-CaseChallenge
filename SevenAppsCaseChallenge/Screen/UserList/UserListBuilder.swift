//
//  UserListBuilder.swift
//  SevenAppsCaseChallenge
//
//  Created by Fatih Kara on 29.01.2025.
//

import Foundation
public class UserListBuilder {
    static func make() -> UserListVC {
        let vc = UserListVC()
        let viewModel = UserListViewModel(service: NetworkCaller())
        vc.viewModel = viewModel
        return vc
    }
}
