import Foundation
import Domain

public struct BookListDTO: Decodable {
    let totalPage: Int
    let items: [Item]
}

public struct Item: Decodable {
    let title: String
    let author: String
    let isbn: String
    let cover: String
    let publisher: String
    let reviewCount: Int
    let likeCount: Int
    let isLiked: Bool
}

extension BookListDTO {
    func toDomain() -> BookListEntity {
        return BookListEntity(
            totalPage: totalPage,
            items: items.map { item in
                    .init(
                        title: item.title,
                        author: item.author,
                        isbn: item.isbn,
                        cover: item.cover,
                        publisher: item.publisher,
                        reviewCount: item.reviewCount,
                        likeCount: item.likeCount,
                        isLiked: item.isLiked
                    )
            }
        )
    }
}
