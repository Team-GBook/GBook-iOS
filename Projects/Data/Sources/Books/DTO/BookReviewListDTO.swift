import Foundation
import Domain

public struct BookReviewListDTO: Decodable {
    let reviewList: [BookRevieElementDTO]
}

public struct BookRevieElementDTO: Decodable {
    let id: String
    let isbn: String
    let title: String
    let user: String
    let isMine: Bool
    let createdAt: String
    let likeCount: Int
    let commentCount: Int
}

extension BookReviewListDTO {
    func toDomain() -> BookReviewListEntity {
        return BookReviewListEntity(
            reviewList: reviewList.map { item in
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
            }
        )
    }
}
