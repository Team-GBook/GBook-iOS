import Foundation
import Domain

public struct UserDTO: Decodable {

    public let email: String
    public let nickName: String
    public let genre: String
    public let profile: String

}

extension UserDTO {
    func toDomain() -> UserEntity {
        return .init(
            email: email,
            nickName: nickName,
            genre: genre,
            profileImage: profile
        )
    }
}
