import Foundation
import Domain

public struct ReviewListDTO: Decodable {
    public let reviewList: [ReviewItem]
}

public struct ReviewItem: Decodable {
    public let id: String
    public let isbn: String
    public let title: String
    public let user: String
    public let isMine: Bool
    public let createdAt: String
    public let likeCount: Int
    public let commentCount: Int
}

extension ReviewListDTO {
    func toDomain() -> BookReviewListEntity {
        return BookReviewListEntity(reviewList: reviewList.map { item in
                .init(
                    id: item.id,
                    isbn: item.isbn,
                    title: item.title,
                    user: item.user,
                    isMine: item.isMine,
                    createdAt: item.createdAt,
                    likeCount: item.likeCount,
                    commentCount: item.commentCount
                )
        })
    }
}
