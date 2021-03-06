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
    case cannotConvert = "데이터를 받아왔지만 원할히 볼 수 없습니다"//"변환 불가"
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
    static func changePassword(currentPassword: String, newPassword: String , confirmNewPassword: String, completion: @escaping(User?, APIError?) -> Void) {
        var request = URLRequest(url: point.changePassword.url)
        
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "currentPassword=\(currentPassword)&newPassword=\(newPassword)&confirmNewPassword=\(confirmNewPassword)"
            .data(using: .utf8,
                  allowLossyConversion: false)
        let userToken = UserDefaults.standard.object(forKey: "token")
        if let userToken = userToken {
            request.allHTTPHeaderFields = ["Authorization":"bearer \(userToken)"]
        }
        
        URLSession.request(point: request, completion: completion)
    }
    
    static func login(identifier: String, pw: String, completion: @escaping (SignUp?, APIError?) -> Void) {
        var request = URLRequest(url: point.login.url)
        
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "identifier=\(identifier)&password=\(pw)"
            .data(using: .utf8,
                  allowLossyConversion: false)
        
        URLSession.request(point: request, completion: completion)
    }
    
    static func getPost(_ startPage: Int, completion: @escaping (GetPost?, APIError?) -> Void) {
        let addURL = point.posts.url.description + "?_sort=created_at:desc&_start=\(startPage)&_limit=10"
        var request = URLRequest(url: URL(string: addURL)!)
        
        request.httpMethod = Method.GET.rawValue
        
        let userToken = UserDefaults.standard.object(forKey: "token")
        if let userToken = userToken {
            request.allHTTPHeaderFields = ["Authorization":"bearer \(userToken)"]
        }
        
        URLSession.request(point: request, completion: completion)
    }
    
    static func detailGetPost(_ post: Int, completion: @escaping (GetPostElement?, APIError?) -> Void) {
        let addURL = point.posts.url.description + "\(post)"
        var request = URLRequest(url: URL(string: addURL)!)
        
        request.httpMethod = Method.GET.rawValue
        
        let userToken = UserDefaults.standard.object(forKey: "token")
        if let userToken = userToken {
            request.allHTTPHeaderFields = ["Authorization":"bearer \(userToken)"]
        }
        
        URLSession.request(point: request, completion: completion)
    }
    
    static func getPostCount(completion: @escaping (Int?, APIError?) -> Void) {
        var request = URLRequest(url: point.allPostCount.url)
        request.httpMethod = Method.GET.rawValue
        
        let userToken = UserDefaults.standard.object(forKey: "token")
        if let userToken = userToken {
            request.allHTTPHeaderFields = ["Authorization":"bearer \(userToken)"]
        }
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
    
    static func editPost(MethodTye: Method, _ editText: String?, _ id: Int, completion: @escaping (WritePost?, APIError?) -> Void) {
        let userToken = UserDefaults.standard.object(forKey: "token")
        
        let addURL = point.postEdit.url.description + "\(id)"
        var request = URLRequest(url: URL(string: addURL)!)
    
        request.httpMethod = MethodTye.rawValue
        
        if let userToken = userToken {
            request.allHTTPHeaderFields = ["Authorization": "bearer \(userToken)"]
            request.allHTTPHeaderFields = ["Content-Type": "application/x-www-form-urlencoded"]
        }

        if MethodTye == .PUT {
            request.httpBody = "text=\(editText!)".data(using: .utf8, allowLossyConversion: false)
        }
        //any
        
        URLSession.request(point: request, completion: completion)
    }
    static func commentGet(_ postNumber: Int, completion: @escaping (GetComment?, APIError?) -> Void) {
        let addURL = point.comments.url.description + "?post=\(postNumber)"
        var request = URLRequest(url: URL(string: addURL)!)
        request.httpMethod = Method.GET.rawValue
        
        let userToken = UserDefaults.standard.object(forKey: "token")
        if let userToken = userToken {
            request.allHTTPHeaderFields = ["Authorization":"bearer \(userToken)"]
        }
        URLSession.request(point: request, completion: completion)
    }
    
    static func commentWrite(_ comment: String,_ post: Int, completion: @escaping (WritePost?, APIError?) -> Void) {
        //post: post ID (게시물 id)
        let userToken = UserDefaults.standard.object(forKey: "token")

        var request = URLRequest(url: point.comments.url)
    
        request.httpMethod = Method.POST.rawValue
        
        if let userToken = userToken {
            request.allHTTPHeaderFields = ["Authorization":"bearer \(userToken)"]
            request.allHTTPHeaderFields = ["Content-Type": "application/x-www-form-urlencoded"]
        }
        
        request.httpBody = "comment=\(comment)&post=\(post)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(point: request, completion: completion)
    }
    
    static func commentEdit(MethodTye: Method, _ comment: String, _ id: Int, _ post: Int, completion: @escaping (WritePost?, APIError?) -> Void) {
        let userToken = UserDefaults.standard.object(forKey: "token")

        let addURL = point.comments.url.description + "/\(id)"
        var request = URLRequest(url: URL(string: addURL)!)
    
        request.httpMethod = MethodTye.rawValue
        
        if let userToken = userToken {
            request.allHTTPHeaderFields = ["Authorization": "bearer \(userToken)"]
            request.allHTTPHeaderFields = ["Content-Type": "application/x-www-form-urlencoded"]
        }
        
        if MethodTye == .PUT {
            request.httpBody = "comment=\(comment)&post=\(post)".data(using: .utf8, allowLossyConversion: false)
        }
        URLSession.request(point: request, completion: completion)
    }
}
