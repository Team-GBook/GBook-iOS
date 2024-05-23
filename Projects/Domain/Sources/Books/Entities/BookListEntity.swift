import Foundation

public struct BookListEntity {
    public let totalPage: Int
    public let items: [Book]
    public init(totalPage: Int, items: [Book]) {
        self.totalPage = totalPage
        self.items = items
    }
}

public struct Book: Decodable {
    public init(title: String, author: String, isbn: String, cover: String, publisher: String, reviewCount: Int, likeCount: Int, isLiked: Bool) {
        self.title = title
        self.author = author
        self.isbn = isbn
        self.cover = cover
        self.publisher = publisher
        self.reviewCount = reviewCount
        self.likeCount = likeCount
        self.isLiked = isLiked
    }
    public let title: String
    public let author: String
    public let isbn: String
    public let cover: String
    public let publisher: String
    public let reviewCount: Int
    public let likeCount: Int
    public let isLiked: Bool
}
