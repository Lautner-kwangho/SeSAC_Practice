//
//  APIManager.swift
//  Assignment67_MemberLogin
//
//  Created by 최광호 on 2022/01/03.
//

import Foundation

enum APIError: String, Error, LocalizedError {
    case badRequest = "유효하지 않은 양식입니다.\n정보를 재확인해주세요"//"Bad Request"
    case alreadyRegist = "이미 등록되어 있습니다"//"Already Regist"
    case lostNetwork = "네트워크 유실"//"Lost Network. Plz Connect wf"
    case failed = "실패하였습니다"//"Failed"
    case unknownError = "unknown 에러"//"Error"
    case noResponse = "응답 없음"//"No Response"
    case noData = "데이터 없음"//"No Data"
    
    var errorDescription: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}

class APIManager {
    
    static func register(username: String, email: String, password: String, completion: @escaping (SignUp?, APIError?) -> Void) {
        
        var request = URLRequest(url: point.signUp.url)
        
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "username=\(username)&email=\(email)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(.shared, point: request, completion: completion)
    }
    
    static func login(identifier: String, pw: String, completion: @escaping (SignUp?, APIError?) -> Void) {
        var request = URLRequest(url: point.login.url)
        
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "identifier=\(identifier)&password=\(pw)"
            .data(using: .utf8,
                  allowLossyConversion: false)
        
        URLSession.request(point: request, completion: completion)
        
    }
    
}
