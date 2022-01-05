//
//  WritePost.swift
//  Assignment67_MemberLogin
//
//  Created by 최광호 on 2022/01/05.
//

import Foundation

// MARK: - WritePost
struct WritePost: Codable {
    let id: Int
    let text: String
    let user: UserInfo
    let createdAt, updatedAt: String
    let comments: [commentWrite]

    enum CodingKeys: String, CodingKey {
        case id, text, user
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case comments
    }
}

// MARK: - User
struct UserInfo: Codable {
    let id: Int
    let username, email, provider: String
    let confirmed: Bool
    let blocked: Bool?
    let role: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, username, email, provider, confirmed, blocked, role
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - Comment
struct commentWrite: Codable {
    let id: Int
    let comment: String
    let user, post: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, comment, user, post
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
