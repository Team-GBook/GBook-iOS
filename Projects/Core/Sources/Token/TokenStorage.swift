import Foundation
import KeychainSwift

//TODO: - 토큰저장소 다시 만들기
public enum TokenType {
    case accessToken
    case refreshToken
    case emptyToken
    
    var tokenKey: String {
        switch self {
        case .accessToken:
            return "ACCESS-TOKEN"
        case .refreshToken:
            return "REFRESH-TOKEN"
        default:
            return ""
        }
    }
}

public class TokenStorage {
    public static let shared = TokenStorage()
    private let keyChain = KeychainSwift()
    
    public var accessToken: String? {
        get {
            keyChain.get(TokenType.accessToken.tokenKey)
        }
        set {
            keyChain.set(newValue ?? "", forKey: TokenType.accessToken.tokenKey)
        }
    }
    public var refreshToken: String? {
        get {
            keyChain.get(TokenType.refreshToken.tokenKey)
        }
        set {
            keyChain.set(newValue ?? "", forKey: TokenType.refreshToken.tokenKey)
        }
    }
    public func toHeader(_ tokenType: TokenType) -> [String: String] {
        guard let accessToken = self.accessToken,
              let refreshToken = self.refreshToken
        else {
            return ["content-type": "application/json"]
        }
        switch tokenType {
        case .accessToken:
            return ["Authorization" : "Bearer " + accessToken, "Contect-Type" : "application/json"]
        case .refreshToken:
            return ["Refresh-Token" : "Bearer " + refreshToken, "Contect-Type" : "application/json"]
        case .emptyToken:
            return ["content-type": "application/json"]
        }
    }
    public func deleteToken() {
        accessToken = nil
        refreshToken = nil
    }
}
