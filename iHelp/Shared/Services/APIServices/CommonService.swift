//
//  CommonService.swift
//
//  Created by Mehedi Hasan on 3/21/19.
//

import Foundation

struct CommonService {
    
    static func signIn(email: String, password: String, completion: @escaping (_ userData: User?, _ token: String?, _ err : Error?) -> Void) {
        
        let params: [String : Any] = ["email": email,
                                      "password": password,
                                      "remember": true]
        
        APIService.performRequest(route: Router.signIn(params: params)) { (result: AFResult<SignInResponse>) in
            switch result {
            case .success(let response):
                completion(response.data, response.token, nil)
            case .failure( let error):
                completion(nil, nil, error)
            }
        }
    }
    
    static func signUp(firstName: String, lastName: String, userType: UserType, email: String, password: String, completion: @escaping (_ success: Bool) -> Void) {
        
        let params: [String : Any] = [
            "first_name": firstName,
            "last_name": lastName,
            "role_id": userType.role_id,
            "email": email,
            "password": password,
            "confirm_password": password
        ]
        
        APIService.performRequest(route: Router.signUp(params: params)) { (result: AFResult<SignUpResponse>) in
            switch result {
            case .success(let response):
                completion(true)
            case .failure( let error):
                completion(false)
            }
        }
    }

    
    static func forgetPassword(email: String, completion: @escaping (_ success: Bool, _ response: ForgetPasswordResponse?) -> Void) {
        
        let params: [String : Any] = ["email": email]
        
        APIService.performRequest(route: Router.forgetPassword(params: params)) { (result: AFResult<ForgetPasswordResponse>) in
            switch result {
            case .success(let response):
                completion(true, response)
            case .failure( let error):
                completion(false, nil)
            }
        }
    }
    
    static func resetPassword(opt: String, password: String, completion: @escaping (_ success: Bool, _ response: ResetPasswordResponse?) -> Void) {
        
        let params: [String : Any] = [
            "otp": opt,
            "password": password,
            "confirm_password": password]
        
        APIService.performRequest(route: Router.resetPassword(params: params)) { (result: AFResult<ResetPasswordResponse>) in
            switch result {
            case .success(let response):
                completion(true, response)
            case .failure( let error):
                completion(false, nil)
            }
        }
    }
    
    static func changePassword(oldPassword: String, newPassword: String, completion: @escaping (_ userData: User?, _ token: String?, _ err : Error?) -> Void) {
        
        let params: [String : Any] = ["old_password": oldPassword,
                                      "new_password": newPassword,
                                      "new_password_confirmation": newPassword]
        
        APIService.performRequest(route: Router.changePassword(params: params)) { (result: AFResult<SignInResponse>) in
            switch result {
            case .success(let response):
                completion(response.data, response.token, nil)
            case .failure( let error):
                completion(nil, nil, error)
            }
        }
    }
    
    
    static func fetchEvents(completion: @escaping (_ events: [IHelpEvent], _ err : Error?) -> Void) {
        
        APIService.performRequest(route: Router.fetchEvents) { (result: AFResult<IHelpEventResponse>) in
            switch result {
            case .success(let response):
                completion(response.data.data, nil)
            case .failure( let error):
                completion([], error)
            }
        }
    }
    
    static func fetchSurveys(completion: @escaping (_ surveys: [IHelpSurvey], _ err : Error?) -> Void) {
        
        APIService.performRequest(route: Router.fetchSurveys) { (result: AFResult<IHelpSurveyResponse>) in
            switch result {
            case .success(let response):
                completion(response.data.data, nil)
            case .failure( let error):
                completion([], error)
            }
        }
    }
    
}
