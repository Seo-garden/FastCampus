//
//  NetworkService.swift
//  Cproject
//
//  Created by 서정원 on 7/25/24.
//

import Foundation
import UIKit

class NetworkService {
    static let shared: NetworkService = NetworkService()
    
    func getHomeData() async throws -> HomeResponse {
        let urlString = "https://my-json-server.typicode.com/JeaSungLEE/JsonAPIFastCampus/db"
        guard let url = URL(string: urlString) else { throw URLError(.badURL)}
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {throw URLError(.badServerResponse)}
        let decodeData = try JSONDecoder().decode(HomeResponse.self, from: data)
        return decodeData
    }
}
