//
//  User.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 6/11/24.
//

import Foundation

struct User: Codable {
    let id: Int
    let fullName, firstName, lastName: String
    let roleID, status: Int
    let email, createdAt, updatedAt: String
    let role: UserRole
    //let permissions: [String]

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case firstName = "first_name"
        case lastName = "last_name"
        case roleID = "role_id"
        case status, email
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case role
        //case permissions
    }
}

struct UserRole: Codable {
    let id: Int
    let name, guardName, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case guardName = "guard_name"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

enum UserType: CaseIterable, Identifiable {
    case caregiver
    case patient
    
    var id: Self { self }
    
    var role_id: Int {
        switch self {
        case .caregiver:
            3
        case .patient:
            4
        }
    }
    
    var title: String {
        switch self {
        case .caregiver:
            "Caregiver"
        case .patient:
            "Patient"
        }
    }
    
}
