//
//  SignUp.swift
//  Assignment67_MemberLogin
//
//  Created by 최광호 on 2022/01/04.
//

import Foundation

/*
//실패했을 때
// MARK: - SignUp
struct SignUp: Codable {
    let statusCode: Int
    let error: String
    let message, data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let messages: [Message]
}

// MARK: - Message
struct Message: Codable {
    let id, message: String
}
*/

// 성공했을 때
// MARK: - SignUp
struct SignUp: Codable {
    let jwt: String
    let user: User
}

// MARK: - User
struct User: Codable {
    let id: Int
    let username, email, provider: String
    let confirmed: Bool
    let blocked: String?
    let role: Role
    let createdAt, updatedAt: String
    let posts: [String]
    let comments: [String]

    enum CodingKeys: String, CodingKey {
        case id, username, email, provider, confirmed, blocked, role
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case posts, comments
    }
}

// MARK: - Role
struct Role: Codable {
    let id: Int
    let name, roleDescription, type: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case roleDescription = "description"
        case type
    }
}

