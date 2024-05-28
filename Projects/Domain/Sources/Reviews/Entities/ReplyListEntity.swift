import Foundation

public struct ReplyListEntity {
    public let replies: [ReplyElement]
    public init(replies: [ReplyElement]) {
        self.replies = replies
    }
}

public struct ReplyElement {
    public let id: String
    public let userName: String
    public let content: String

    public init(
        id: String,
        userName: String,
        content: String
    ) {
        self.id = id
        self.userName = userName
        self.content = content
    }
}
