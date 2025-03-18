//
//  SignupViewModel.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 6/12/24.
//

import SwiftUI
import Combine

class SignupViewModel: ObservableObject {
    
    @Published var firstName = "" {
        didSet {
            clearErrorMessageIfNeeded()
        }
    }
    @Published var lastName = "" {
        didSet {
            clearErrorMessageIfNeeded()
        }
    }
    @Published var userType: UserType = .caregiver {
        didSet {
            clearErrorMessageIfNeeded()
        }
    }
    @Published var email = "" {
        didSet {
            clearErrorMessageIfNeeded()
        }
    }
    @Published var password = "" {
        didSet {
            clearErrorMessageIfNeeded()
        }
    }
    @Published var confirmPassword = "" {
        didSet {
            clearErrorMessageIfNeeded()
        }
    }
    
    
    @Published private(set) var state: ViewState = .idle
    
    private var cancellables = Set<AnyCancellable>()


    func signup() {

        guard !firstName.isEmpty else {
            state = .failure(AuthenticationError.firstNameEmpty)
            return
        }
        guard !lastName.isEmpty else {
            state = .failure(AuthenticationError.lastNameEmpty)
            return
        }
        guard !email.isEmpty else {
            state = .failure(AuthenticationError.emailEmpty)
            return
        }
        guard !password.isEmpty else {
            state = .failure(AuthenticationError.passwordEmpty)
            return
        }
        guard password == confirmPassword else {
            state = .failure(AuthenticationError.passwordDontMatch)
            return
        }
        
        state = .loading
        
        CommonService.signUp(firstName: firstName, lastName: lastName, userType: userType, email: email, password: password) { [weak self] success in
            DispatchQueue.main.async {
                if success {
                    self?.state = .success
                } else {
                    self?.state = .failure(AuthenticationError.somethingError)
                }
            }
        }
    }
    
    private func clearErrorMessageIfNeeded() {
        if case .failure = state {
            state = .idle
        }
    }
}


