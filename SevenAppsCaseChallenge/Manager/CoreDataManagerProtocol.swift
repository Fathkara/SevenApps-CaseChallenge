//
//  CoreDataManagerProtocol.swift
//  SevenAppsCaseChallenge
//
//  Created by Fatih Kara on 30.01.2025.
//

import Foundation

protocol CoreDataManagerProtocol {
    func addUserList(value: UserListModel)
    func deleteUserList(value: UserList)
    func fetchUserList() -> [UserList]
}

class CoreDataManager: CoreDataManagerProtocol {
    let context = appDelegate.persistentContainer.viewContext
    var userList: [UserList] = []
    
    func fetchUserList() -> [UserList] {
        do{
            userList = try context.fetch(UserList.fetchRequest())
        }catch{
            print(error)
        }
        return userList
    }
    
    func addUserList(value: UserListModel) {
        
        let userListFav = self.fetchUserList()
        var idList: [Int16] = []
        
        for i in userListFav {
            idList.append(i.id)
        }
        
        if !(idList.contains(Int16(Int(value.id )))) {
            let userList = UserList(context: context)
            userList.name = value.name
            userList.email = value.email
            userList.id = Int16(value.id)
            appDelegate.saveContext()
        }
    }
    
    func deleteUserList(value: UserList) {
        self.context.delete(value)
        appDelegate.saveContext()
    }
}
