//
//  SignInResponse.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 6/5/24.
//

import Foundation

struct SignInResponse: Codable {
    let status: String
    let code: Int
    let message: String
    let data: User
    let token: String
}

struct SignUpResponse: Codable {
    let status: String
    let code: Int
    let message: String
}

struct ForgetPasswordResponse: Codable {
    let status: String
    let code: Int
    let message: String
    //let data: String
}

struct ResetPasswordResponse: Codable {
    let status: String
    let code: Int
    let message: String
    //let data: String
}
