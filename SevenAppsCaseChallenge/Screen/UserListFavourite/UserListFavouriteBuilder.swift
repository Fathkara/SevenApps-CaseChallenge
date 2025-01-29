//
//  UserListFavouriteBuilder.swift
//  SevenAppsCaseChallenge
//
//  Created by Fatih Kara on 30.01.2025.
//

import Foundation
class UserListFavoriteBuilder {
    static func make() -> UserListFavouriteVC {
        let vc = UserListFavouriteVC()
        let viewModel = UserListFavoriteViewModel(coreDataManager: CoreDataManager())
        vc.viewModel = viewModel
        return vc
    }
}
