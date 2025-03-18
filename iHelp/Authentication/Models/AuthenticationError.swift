//
//  AuthenticationError.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 7/17/24.
//

import Foundation

enum AuthenticationError: LocalizedError {
    case somethingError
    case firstNameEmpty
    case lastNameEmpty
    case emailEmpty
    case passwordEmpty
    case passwordDontMatch
    case optEmpty
    
    var errorDescription: String? {
        switch self {
        case .somethingError:
            "something went wrong!"
        case .firstNameEmpty:
            "First name cannot be empty"
        case .lastNameEmpty:
            "Last name cannot be empty"
        case .emailEmpty:
            "Email cannot be empty"
        case .passwordEmpty:
            "Password cannot be empty"
        case .passwordDontMatch:
            "Passwords do not match"
        case .optEmpty:
            "OPT cannot be empty"
        }
    }
}
