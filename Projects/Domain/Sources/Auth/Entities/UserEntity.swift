import Foundation

public struct UserEntity {

    public let email: String
    public let nickName: String
    public let genre: String
    public let profileImage: String

    public init(
        email: String,
        nickName: String,
        genre: String,
        profileImage: String
    ) {
        self.email = email
        self.nickName = nickName
        self.genre = genre
        self.profileImage = profileImage
    }
}
