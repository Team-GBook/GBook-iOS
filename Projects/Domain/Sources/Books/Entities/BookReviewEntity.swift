import Foundation

public struct BookReviewListEntity {
    public let reviewList: [BookReviewElement]
    public init(reviewList: [BookReviewElement]) {
        self.reviewList = reviewList
    }
}

public struct BookReviewElement {
    public let isbn: String
    public let title: String
    public let user: String
    public let isMine: Bool
    public let createdAt: String
    public let likeCount: Int
    public let commentCount: Int

    public init(
        isbn: String,
        title: String,
        user: String, 
        isMine: Bool,
        createdAt: String,
        likeCount: Int,
        commentCount: Int
    ) {
        self.isbn = isbn
        self.title = title
        self.user = user
        self.isMine = isMine
        self.createdAt = createdAt
        self.likeCount = likeCount
        self.commentCount = commentCount
    }
}
