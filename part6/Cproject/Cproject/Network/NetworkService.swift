//
//  NetworkService.swift
//  Cproject
//
//  Created by 서정원 on 7/25/24.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case responseError
    case decodeError
    case serverError(statusCode: Int)
    case unkwonError
}
//아래와 같은 방식이 URLSession
class NetworkService {
    static let shared: NetworkService = NetworkService()        //싱글톤 객체를 유지해야 하기 때문에 static 키워드를 써야 한다.
    
    private let hostURL = "https://my-json-server.typicode.com/JeaSungLEE/"
    
    private func createURL(withPath path: String) throws -> URL {       //오류가 발생할 수 있는 throws
        let urlString = "\(hostURL)\(path)"
        guard let url = URL(string: urlString) else { throw NetworkError.urlError }
        return url
    }
    
    private func fetchData(from url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)      //await 의 역할은 비동기 작업이 완료되기 전까지 반환되지 않도록 한다.
        guard let httpResponse = response as? HTTPURLResponse else { throw NetworkError.responseError }
        
        switch httpResponse.statusCode {
        case 200...299:
            return data
        default:
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        }
    }
    
    func getHomeData() async throws -> HomeResponse {
        let url = try createURL(withPath: "/JsonAPIFastCampus/db")
        let data = try await fetchData(from: url)
        do {
            let decodeData = try JSONDecoder().decode(HomeResponse.self, from: data)
            return decodeData
        } catch {
            throw NetworkError.decodeError
        }
    }
    
    func getFavoriteData() async throws -> FavoritesResponse {
        let url = try createURL(withPath: "/jsonapifastcampusfavorite/db")
        let data = try await fetchData(from: url)
        do {
            let decodeData = try JSONDecoder().decode(FavoritesResponse.self, from: data)
            return decodeData
        } catch {
            throw NetworkError.decodeError
        }
    }
    
    func getProductDetailData() async throws -> ProductDetailResponse {
        let url = try createURL(withPath: "/JsonAPIFastCampusProductDetail/db")
        let data = try await fetchData(from: url)
        do {
            let decodeData = try JSONDecoder().decode(ProductDetailResponse.self, from: data)
            return decodeData
        } catch {
            throw NetworkError.decodeError
        }
    }
}
