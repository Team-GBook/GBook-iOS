import Foundation

public struct CommentListEntity {
    public let comments: [CommentElement]
    public init(comments: [CommentElement]) {
        self.comments = comments
    }
}

public struct CommentElement {
    public let id: String
    public let userName: String
    public let content: String
    public let replyCount: Int

    public init(
        id: String,
        userName: String,
        content: String,
        replyCount: Int
    ) {
        self.id = id
        self.userName = userName
        self.content = content
        self.replyCount = replyCount
    }
}
