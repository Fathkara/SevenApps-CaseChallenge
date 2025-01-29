//
//  UserListDetailBuilder.swift
//  SevenAppsCaseChallenge
//
//  Created by Fatih Kara on 29.01.2025.
//

import Foundation
class UserListDetailBuilder {
    static func make(id: Int) -> UserListDetailVC {
        let vc = UserListDetailVC()
        let viewModel = UserListDetailViewModel(service: NetworkCaller(), id: id, coreDataManager: CoreDataManager())
        vc.viewModel = viewModel
        return vc
    }
}
