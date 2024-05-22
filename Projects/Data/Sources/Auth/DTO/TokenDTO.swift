import Foundation

public struct TokenDTO: Decodable {
    enum CodingKeys: String, CodingKey {
        case accessToken = "accessToken"
        case refreshToken = "refreshToken"
    }

    let accessToken: String
    let refreshToken: String
}
