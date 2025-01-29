//
//  UserListFavouriteViewModel.swift
//  SevenAppsCaseChallenge
//
//  Created by Fatih Kara on 30.01.2025.
//

import Foundation

protocol UserListFavoriteViewModelProtocol {
    var output: UserListFavoriteOutput? {get set}
    func deleteCoreData(list: UserList)
    func fetchCoreData()
}

protocol UserListFavoriteOutput {
    func favoriteUserList(data: [UserList])
}

class UserListFavoriteViewModel: UserListFavoriteViewModelProtocol {
    var output: UserListFavoriteOutput?
    var coreDataManager: CoreDataManagerProtocol?
    
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
    }
}

extension UserListFavoriteViewModel {
    func deleteCoreData(list: UserList) {
        coreDataManager?.deleteUserList(value: list)
    }
    
    func fetchCoreData() {
        let favUserList = coreDataManager?.fetchUserList()
        output?.favoriteUserList(data: favUserList!)
    }
}
