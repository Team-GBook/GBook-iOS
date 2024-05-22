import Foundation

public struct TokenDTO: Decodable {
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }

    let accessToken: String
    let refreshToken: String
}