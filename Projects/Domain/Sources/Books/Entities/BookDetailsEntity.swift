import Foundation

public struct BookDetailsEntity {

    public let title: String
    public let author: String
    public let isbn: String
    public let cover: String
    public let publisher: String
    public let description: String
    public let reviewCount: Int
    public let likeCount: Int
    public let isLiked: Bool

    public init(
        title: String,
        author: String,
        isbn: String,
        cover: String, 
        publisher: String,
        description: String,
        reviewCount: Int,
        likeCount: Int,
        isLiked: Bool
    ) {
        self.title = title
        self.author = author
        self.isbn = isbn
        self.cover = cover
        self.publisher = publisher
        self.description = description
        self.reviewCount = reviewCount
        self.likeCount = likeCount
        self.isLiked = isLiked
    }
}
