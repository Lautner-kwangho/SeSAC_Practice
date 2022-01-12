//
//  GetComment.swift
//  Assignment67_MemberLogin
//
//  Created by 최광호 on 2022/01/08.
//

import Foundation

// MARK: - GetCommentElement
struct GetCommentElement: Codable {
    
    let id: Int
    let comment: String
    let user: UsersInfo
    let post: PostInfo
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, comment, user, post
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - Post
struct PostInfo: Codable {
    let id: Int
    let text: String
    let user: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, text, user
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - User
struct UsersInfo: Codable {
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

typealias GetComment = [GetCommentElement]
