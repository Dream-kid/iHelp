//
//  AuthenticationManager.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 1/17/24.
//

import Foundation

class AuthenticationManager: ObservableObject {
    
    static let shared = AuthenticationManager()
    
    @Published var isAuthenticated = false
    @Published var currentUser: User? = nil
    var token: String?
    
    
    private init() {}
    
    
    func login(email: String, password: String, completion: @escaping (_ success: Bool) -> Void) {

        CommonService.signIn(email: email, password: password) { user, token, error in

            if let error = error {
                completion(false)
            } else {
                completion(true)
                self.isAuthenticated = true
                self.currentUser = user
                self.token = token
            }
        }
    }

    
    func logout() {
        // Implement logout logic
        isAuthenticated = false
        self.currentUser = nil
        self.token = nil
    }
    
    
    /*func signup(firstName: String, lastName: String, userType: UserType, email: String, password: String, completion: @escaping (_ success: Bool) -> Void) {
        CommonService.signUp(firstName: firstName, lastName: lastName, userType: userType, email: email, password: password) { success in
            completion(success)
        }
    }*/
}
