import Moya
import Foundation
import Core

public enum AuthAPI {
    case login(
        email: String,
        password: String
    )
    case sendEmail(email: String)
    case emailCheck(
        email: String,
        code: Int
    )
    case signup(
        email: String,
        password: String,
        nickName: String,
        genre: String
    )
}

extension AuthAPI: TargetType {
    public var baseURL: URL {
        return BaseURL.baseURL
    }
    
    public var path: String {
        switch self {
        case .login:
            return "/users/login"
        case .sendEmail:
            return "/users/email"
        case .emailCheck:
            return "/users/email/check"
        case .signup:
            return "/users/signup"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .login, .sendEmail, .emailCheck, .signup:
            return .post
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .login(let email, let password):
            return .requestParameters(
                parameters: [
                    "email": email,
                    "password": password
                ], encoding: JSONEncoding.default)
        case .sendEmail(let email):
            return .requestParameters(parameters: [
                "email": email
            ],encoding: URLEncoding.queryString)
        case .emailCheck(let email, let code):
            return .requestParameters(
                parameters: [
                    "email": email,
                    "code": code
                ], encoding: URLEncoding.queryString)
        case .signup(let email, let password, let nickName, let genre):
            return .requestParameters(
                parameters: [
                    "email": email,
                    "password": password,
                    "nickName": nickName,
                    "genre": genre
                ], encoding: JSONEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        return .none
    }
}
