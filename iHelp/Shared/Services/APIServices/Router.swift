//
//  Router.swift
//  VoiceMate
//

import Foundation


enum Router: APIRouter {
    
    case signIn(params: Dictionary<String, Any>)
    case signUp(params: Dictionary<String, Any>)
    case signout
    case forgetPassword(params: Dictionary<String, Any>)
    case resetPassword(params: Dictionary<String, Any>)
    case changePassword(params: Dictionary<String, Any>)

    case fetchEvents
    case fetchSurveys

    
    //MARK: method
    var method: HTTPMethod {
        switch self {
        case .signIn:
            return .post
        case .signUp:
            return .post
        case .signout:
            return .post
        case .forgetPassword:
            return .post
        case .resetPassword:
            return .post
        case .changePassword:
            return .post
        case .fetchEvents:
            return .get
        case .fetchSurveys:
            return .get
        }
    }
    
    //MARK: path
    var path: String {
        switch self {
        case .signIn:
            "/v1/signin"
        case .signUp:
            "/v1/signup"
        case .signout:
            "/v1/signout"
        case .forgetPassword:
            "/v1/forgot-password"
        case .resetPassword:
            "/v1/reset-password"
        case .changePassword:
            "v1/change-password"
        case .fetchEvents:
            "/v1/events?sort=created_at,desc&per_page=100&current_page=1"
        case .fetchSurveys:
            "/v1/survey-list?per_page=100&current_page=1&lang=en"

        }
    }
    
    var baseURL: String {
        switch self {
        case .signIn, .signUp, .signout, .fetchEvents, .fetchSurveys, .forgetPassword, .changePassword, .resetPassword:
            return "https://api.ihelpcare.org/api"
            //return "https://ihelp.api.trydemo.dev/api"
        //case .fetchEvents, .fetchSurveys:
//        case .fetchSurveys:
//            return "http://localhost:3000"
        }
    }

    //MARK: parameters
    var parameters: Parameters? {
        switch self {
        case .fetchEvents:
            return nil
        case .fetchSurveys:
            return nil
        //default:
            //return [:]
        case .signIn(let dict):
            return dict
        case .signUp(let dict):
            return dict
        case .signout:
            return nil
        case .forgetPassword(let dict):
            return dict
        case .changePassword(let dict):
            return dict
        case .resetPassword(let dict):
            return dict
        }
    }
    
    
    //MARK: bodyData
    var bodyData: Data? {
        switch self {
//        case .transactionData(let data):
//            return data
        default:
            return nil
        }
    }
    
//    var cachePolicy: NSURLRequest.CachePolicy {
//        switch self {
//        case .getAllNotifications:
//            return .returnCacheDataElseLoad
//        default:
//            return .useProtocolCachePolicy
//        }
//    }
    
    //MARK: ContentType
    var contentType: ContentType? {
        switch self {
//        case .uploadFile:
//            //return ContentType.multipartFormData.rawValue
//            return nil
        default:
            return .json
        }
    }
    
    var sessionCheck: Bool {
        switch self {
        default:
            return false
        }
    }
    
    var imageDataTuple: (String, Data)? {
        switch self {
        default:
            return nil
        }
    }
}
