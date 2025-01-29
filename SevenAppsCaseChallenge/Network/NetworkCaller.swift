//
//  NetworkCaller.swift
//  SevenAppsCaseChallenge
//
//  Created by Fatih Kara on 29.01.2025.
//

import Foundation
protocol NetworkServiceProtocol {
    func fetchData<T: Decodable>(_ endPoint: EndPoint) async throws -> T
}

final class NetworkCaller: NetworkServiceProtocol {
    
    func fetchData<T: Decodable>(_ endPoint: EndPoint) async throws -> T {
        
        let (data, response) = try await URLSession.shared.data(for: endPoint.request())
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
