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
    
    static func getPost(completion: @escaping (GetPost?, APIError?) -> Void) {
        let userToken = UserDefaults.standard.object(forKey: "token")
        var request = URLRequest(url: point.posts.url)
    
        request.httpMethod = Method.GET.rawValue
        
        if let userToken = userToken {
            request.allHTTPHeaderFields = ["Authorization":"bearer \(userToken)"]
        }
        
        print(userToken)
        
        URLSession.request(point: request, completion: completion)
    }
    
    static func writePost(_ text: String, completion: @escaping (WritePost?, APIError?) -> Void) {
        let userToken = UserDefaults.standard.object(forKey: "token")
        var request = URLRequest(url: point.posts.url)
    
        request.httpMethod = Method.POST.rawValue
        
        if let userToken = userToken {
            request.allHTTPHeaderFields = ["Authorization":"bearer \(userToken)"]
        }
        
        request.httpBody = "text=\(text)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(point: request, completion: completion)
    }
    
    static func editPost(MethodTye: Method, _ editText: String?, _ id: Int, completion: @escaping (EditPost?, APIError?) -> Void) {
        let userToken = UserDefaults.standard.object(forKey: "token")
        
        let addURL = point.postEdit.url.description + "\(id)"
        var request = URLRequest(url: URL(string: addURL)!)
    
//        request.httpMethod = Method.PUT.rawValue
        request.httpMethod = MethodTye.rawValue
        
        if let userToken = userToken {
            request.allHTTPHeaderFields = ["Authorization":"bearer \(userToken)"]
        }
        if let text = editText {
            request.httpBody = "text=\(text)".data(using: .utf8, allowLossyConversion: true)
        }
        print("메인",request)
        print("메인",editText)
        print("메인",userToken!)
        print("메인",MethodTye.rawValue)
        
        
        URLSession.request(point: request, completion: completion)
        print("얘는 왜 위에처럼 안바뀌냐고!!!ㅜㅉㄲ라ㅓㅣ몬유허ㅔㅏㅠ노;라ㅣㅓ")
    }
}
