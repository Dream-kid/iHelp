//
//  LoginViewModel.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 6/5/24.
//

import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    
    @Published var email: String = "" {
        didSet {
            if !email.isEmpty && !password.isEmpty {
                state = .idle
            }
        }
    }
    @Published var password: String = "" {
        didSet {
            if !email.isEmpty && !password.isEmpty {
                state = .idle
            }
        }
    }
    @Published private(set) var state: ViewState = .idle
    
    private var cancellables = Set<AnyCancellable>()


    func login() {

        guard !email.isEmpty, !password.isEmpty else {
            self.state = .failure(LoginError.emptyField)
            return
        }
        
        state = .loading
        
        AuthenticationManager.shared.login(email: email, password: password) { [weak self] success in
            DispatchQueue.main.async {
                if success {
                    self?.state = .success
                } else {
                    self?.state = .failure(LoginError.invalidCredentials)
                }
            }
        }
    }
}


enum LoginError: LocalizedError {
    case invalidCredentials
    case emptyField
    
    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Invalid credentials or something went wrong!"
        case .emptyField:
            return "Email or password cannot be null or empty!"
        }
    }
}




