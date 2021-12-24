//
//  APIManager.swift
//  Assignment60_Drama
//
//  Created by 최광호 on 2021/12/25.
//

import Foundation

enum APIERROR: Int, Error {
    /*
    case 400 : "Validation failed."case 400 :
    case 401 = "Authentication failed: You do not have permissions to access the service."case 401 =
    case 403 = Duplicate entry: The data you tried to submit already exists.case 403 =
    case 404 = "Invalid id: The pre-requisite id is invalid or not found."case 404 =
    case 405 = "Invalid format: This service doesn't exist in that format."case 405 =
    case 406 = "Invalid accept header."case 406 =
    case 422 = "Invalid parameters: Your request parameters are incorrect."case 422 =
    case 429 = "Your request count (#) is over the allowed limit of (40)."case 429 =
    case 500 = "Internal error: Something went wrong, contact TMDB."case 500 =
    case 501 = "Invalid service: this service does not exist."case 501 =
    case 502 = "Couldn't connect to the backend server."case 502 =
    case 503 = "Service offline: This service is temporarily offline, try again later."case 503 =
    case 504 = "Your request to the backend server timed out. Try again."case 504 =
     */
    case ValidationFailed = 400
    case AuthenticationFailed = 401
    case DuplicateEntry = 403
    case InvalidId = 404
    case InvalidFormat = 405
    case InvalidAcceptHeader = 406
    case InvalidParameters = 422
    case overTheAllowedLimit = 429
    case InternalError = 500
    case InvalidService = 501
    case FailedConnectToTheBackendServer = 502
    case ServiceOffline = 503
    case backendServerTimedOut = 504
}

class APIManager {
    static let shared = APIManager()
    
    func tvPopularAPI(completion: @escaping(TV?) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/tv/popular?api_key=\(APIKEY.tvPopular)&language=ko&page=1")!
        //https://image.tmdb.org/t/p/w500/ 이미지 추가 하는 url
        //https://image.tmdb.org/t/p/original/
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            print(data)
            print(error)
            print(response)
            
            if let error = error {
                print(error)
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else { print("error")
                return
            }
            if let data = data, let tvData = try? JSONDecoder().decode(TV.self, from: data) {
                completion(tvData)
                return
            }
            completion(nil)

        }.resume()
        
    }
}
