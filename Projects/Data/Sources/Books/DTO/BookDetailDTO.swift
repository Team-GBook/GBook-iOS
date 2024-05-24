import Foundation
import Domain

public struct BookDetailDTO: Decodable {
    public let title: String
    public let author: String
    public let isbn: String
    public let cover: String
    public let publisher: String
    public let description: String
    public let reviewCount: Int
    public let likeCount: Int
    public let isLiked: Bool
}

extension BookDetailDTO {
    func toDomain() -> BookDetailsEntity {
        return .init(
            title: title,
            author: author,
            isbn: isbn,
            cover: cover,
            publisher: publisher,
            description: description,
            reviewCount: reviewCount,
            likeCount: likeCount,
            isLiked: isLiked
        )
    }
}
