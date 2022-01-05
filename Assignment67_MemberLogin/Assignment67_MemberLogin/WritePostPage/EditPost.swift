//
//  EditPost.swift
//  Assignment67_MemberLogin
//
//  Created by 최광호 on 2022/01/06.
//
// 설마 이거때문인가 ㅜㅜ
// 이것도 아님 ㅡㅡ 
import Foundation
// MARK: - WritePost
struct EditPost: Codable {
    let id: Int
    let text: String
    let user: UserEdit
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, text, user
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - User
struct UserEdit: Codable {
    let id: Int
    let username, email, provider: String
    let confirmed: Bool
    let role: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, username, email, provider, confirmed, role
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
