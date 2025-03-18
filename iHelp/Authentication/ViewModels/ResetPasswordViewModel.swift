//
//  ResetPasswordViewModel.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 7/10/24.
//

import SwiftUI
import Combine

class ResetPasswordViewModel: ObservableObject {

    @Published var opt = "" {
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


    func resetPassword() {
        guard !opt.isEmpty else {
            state = .failure(AuthenticationError.optEmpty)
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
        CommonService.resetPassword(opt: opt, password: password) { [weak self] success, response in
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
