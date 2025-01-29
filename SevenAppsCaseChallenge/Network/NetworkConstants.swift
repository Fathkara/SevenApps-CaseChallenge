//
//  NetworkConstants.swift
//  SevenAppsCaseChallenge
//
//  Created by Fatih Kara on 29.01.2025.
//

import Foundation
protocol EndPointProtocol {
    var baseURL: String {get}
    var userURL: String {get}
    var method: HTTPMethod {get}
    
    func userApiURL() -> String
    func request() -> URLRequest
}

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
}
enum EndPoint {
    case userList
    case userListDetail
}

extension EndPoint: EndPointProtocol {
    
    var baseURL: String {
        return "https://jsonplaceholder.typicode.com/"
    }
    
    var userURL: String {
        switch self {
        case .userList:
            return "users"
        case .userListDetail:
            return "users"
        }
    }
    var method: HTTPMethod {
        switch self {
        case.userList:
            return .get
        case.userListDetail:
            return .get
        }
    }
    
    func userApiURL() -> String {
        return "\(baseURL)\(userURL)"
    }
    
    func request() -> URLRequest {
        guard let apiURL = URLComponents(string: userApiURL()) else {
            fatalError("URLComponents olusturulamadı")
        }
        
        guard let url = apiURL.url else {
            fatalError("url oluşturulamadı")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        return request
    }
    
    
}
