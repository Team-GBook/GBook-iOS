import Foundation

public struct ReviewListEntity {
    public let reviewList: [ReviewElement]

    public init(reviewList: [ReviewElement]) {
        self.reviewList = reviewList
    }
}

public struct ReviewElement {
    public let id: String
    public let isbn: String
    public let title: String
    public let user: String
    public let isMine: Bool
    public let createdAt: String
    public let likeCount: Int
    public let commentCount: Int

    public init(
        id: String,
        isbn: String,
        title: String,
        user: String,
        isMine: Bool,
        createdAt: String,
        likeCount: Int,
        commentCount: Int
    ) {
        self.id = id
        self.isbn = isbn
        self.title = title
        self.user = user
        self.isMine = isMine
        self.createdAt = createdAt
        self.likeCount = likeCount
        self.commentCount = commentCount
    }
}
