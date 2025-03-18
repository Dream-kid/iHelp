//
//  ChangePasswordViewModel.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 7/17/24.
//

import SwiftUI
import Combine

class ChangePasswordViewModel: ObservableObject {

    @Published var oldPassword = "" {
        didSet {
            clearErrorMessageIfNeeded()
        }
    }

    @Published var newPassword = "" {
        didSet {
            clearErrorMessageIfNeeded()
        }
    }
    @Published var confirmNewPassword = "" {
        didSet {
            clearErrorMessageIfNeeded()
        }
    }
    
    
    @Published private(set) var state: ViewState = .idle
    
    private var cancellables = Set<AnyCancellable>()


    func changePassword() {
        guard !oldPassword.isEmpty else {
            state = .failure(AuthenticationError.optEmpty)
            return
        }
        
        guard !newPassword.isEmpty else {
            state = .failure(AuthenticationError.passwordEmpty)
            return
        }
        guard newPassword == confirmNewPassword else {
            state = .failure(AuthenticationError.passwordDontMatch)
            return
        }
        
        state = .loading
        CommonService.changePassword(oldPassword: oldPassword, newPassword: newPassword) { [weak self] userData, token, err in
            DispatchQueue.main.async {
                if err == nil {
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
