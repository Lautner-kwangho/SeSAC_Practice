//
//  URLSession+Extension.swift
//  Assignment67_MemberLogin
//
//  Created by 최광호 on 2022/01/03.
//

import Foundation

enum Method: String {
    case GET
    case POST
    case PUT
    case DELETE
}

enum point {
    case signUp
    case login
    case changePassword
    
    var url: URL {
        switch self {
        case .signUp:
            return .makeURL("auth/local/register")
        case .login:
            return .makeURL("auth/local")
        case .changePassword:
            return .makeURL("/custom/change-password")
        }
    }
}

extension URL {
    static let baseURL = "http://test.monocoding.com/"
    
    static func makeURL(_ point: String) -> URL {
        URL(string: baseURL + point)!
    }
}

extension URLSession {
    
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    
    @discardableResult
    func dataTask(_ point: URLRequest, handler: @escaping Handler) -> URLSessionDataTask {
        let task = dataTask(with: point, completionHandler: handler)
        task.resume()
        return task
    }
    
    static func request<T: Decodable>(_ session: URLSession = .shared, point: URLRequest, completion: @escaping (T?, APIError?) -> Void) {
        session.dataTask(point) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(nil, .unknownError)
                    return
                }
                
                guard let data = data else {
                    completion(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completion(nil, .noResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    completion(nil, .badRequest)
                    return
                }
                
                do {
                    let userData = try JSONDecoder().decode(T.self, from: data)
                    completion(userData, nil)
                } catch {
                    completion(nil, .lostNetwork)
                }
                
            }
        }
    }
}
