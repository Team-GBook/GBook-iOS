import Moya
import Foundation
import Core

public enum AuthAPI {
    case login(
        email: String,
        password: String
    )
    case sendEmail(email: String)
    case fetchUserProfile
    case editProfile(name: String)
    case uploadImage(image: Data)
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
        case .fetchUserProfile:
            return "/users/"
        case .uploadImage:
            return "/users/profile"
        case .editProfile:
            return "/users"
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
        case .fetchUserProfile:
            return .get
        case .login, .sendEmail, .emailCheck, .signup:
            return .post
        case .editProfile, .uploadImage:
            return .patch
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
        case .editProfile(let name):
            return .requestParameters(
                parameters: [
                    "nickName": name,
                    "genre": "COMICS"
                ], encoding: JSONEncoding.default)
        case .uploadImage(let image):
            let pngData = MultipartFormData(
                      provider: .data(image),
                      name: "file",
                      fileName: "file.png",
                      mimeType: "file/png"
                  )
            return .uploadMultipart([pngData])
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
        default:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .editProfile, .uploadImage, .fetchUserProfile:
            return TokenStorage.shared.toHeader(.accessToken)
        default:
            return .none
        }
    }
}
