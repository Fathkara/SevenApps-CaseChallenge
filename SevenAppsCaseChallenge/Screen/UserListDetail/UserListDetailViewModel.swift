//
//  UserListDetailViewModel.swift
//  SevenAppsCaseChallenge
//
//  Created by Fatih Kara on 29.01.2025.
//

import Foundation
protocol UserListDetailViewModelProtocol {
    var delegate : UserListDetailViewModelDelegate? {get set}
    func loadDetail() async
    func addCoreData(data: UserListModel)
    
    
}
enum UserListDetailModelOutPut {
    case userList([UserListModel])
    case error(URLError.Code)
}

protocol UserListDetailViewModelDelegate {
    func handlerOutput(output: UserListDetailModelOutPut)
}

final class UserListDetailViewModel: UserListDetailViewModelProtocol {
    var delegate: UserListDetailViewModelDelegate?
    var service: NetworkServiceProtocol
    var id: Int?
    var allUsers: [UserListModel] = [] 
    var coreDataManager: CoreDataManagerProtocol?
    
    init(service: NetworkServiceProtocol,id: Int,coreDataManager: CoreDataManagerProtocol) {
        self.service = service
        self.id = id
        self.coreDataManager = coreDataManager
        
    }
    @MainActor
    func loadDetail() async {
        do {
            let users: [UserListModel] = try await service.fetchData(EndPoint.userList)
            self.allUsers = users
            
            if let id = id, let user = users.first(where: { $0.id == id }) {
                
                self.delegate?.handlerOutput(output: .userList([user]))
                
            } else {
                self.delegate?.handlerOutput(output: .error(URLError.badServerResponse))
                
            }
        } catch {
            
            self.delegate?.handlerOutput(output: .error(URLError.badServerResponse))
            
        }
    }
    
    func addCoreData(data: UserListModel) {
        coreDataManager?.addUserList(value: data)
    }
    
}
