import Foundation
import Domain

public struct CommentListDTO: Decodable {
    public let comments: [CommentItem]
}

public struct CommentItem: Decodable {
    public let id: String
    public let username: String
    public let content: String
    public let replyCount: Int
}

extension CommentListDTO {
    func toDomain() -> CommentListEntity {
        return CommentListEntity(comments: comments.map { item in
                .init(
                    id: item.id,
                    userName: item.username,
                    content: item.content,
                    replyCount: item.replyCount
                )
        })
    }
}
