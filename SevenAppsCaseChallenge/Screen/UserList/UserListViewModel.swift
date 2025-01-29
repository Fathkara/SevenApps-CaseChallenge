//
//  UserListViewModel.swift
//  SevenAppsCaseChallenge
//
//  Created by Fatih Kara on 29.01.2025.
//

import Foundation

protocol UserListViewModelProtocol {
    var delegate : UserListViewModelDelegate? {get set}
    func load() async
    
}
enum UserListViewModelOutPut {
    case userList([UserListModel])
    case error(URLError.Code)
}

protocol UserListViewModelDelegate {
    func handlerOutput(output: UserListViewModelOutPut)
}

final class UserListViewModel: UserListViewModelProtocol {
    var delegate: UserListViewModelDelegate?
    var service: NetworkServiceProtocol
    
    init(service: NetworkServiceProtocol) {
        self.service = service
    }
    
    @MainActor
    func load() async {
        Task {
            do {
                let users: [UserListModel] = try await service.fetchData(EndPoint.userList)
                    self.delegate?.handlerOutput(output: .userList(users))
                
            } catch {
                self.delegate?.handlerOutput(output: .error(URLError.badServerResponse))
            }
        }
    }
    
}
