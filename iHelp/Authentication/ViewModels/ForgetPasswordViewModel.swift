//
//  ForgetPasswordViewModel.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 7/3/24.
//

import SwiftUI
import Combine


class ForgetPasswordViewModel: ObservableObject {

    @Published var email = "" {
        didSet {
            clearErrorMessageIfNeeded()
        }
    }

    
    @Published private(set) var state: ViewState = .idle
    @Published var shouldNavigateToResetView: Bool = false
    
    private var cancellables = Set<AnyCancellable>()

    
//    var isResetingPasswordState: Bool {
//        switch state {
//        case .resetPassword: return true
//        default: return false
//            
//        }
//    }


    func resetPassword() {


        guard !email.isEmpty else {
            state = .failure(AuthenticationError.emailEmpty)
            return
        }
        
        state = .loading
        
        CommonService.forgetPassword(email: email) { [weak self] success, response in
            DispatchQueue.main.async {
                if success {
                    self?.state = .success
                    self?.shouldNavigateToResetView = true
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
