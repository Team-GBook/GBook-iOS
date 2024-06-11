import Foundation
import Domain

public struct ReplyListDTO: Decodable {
    public let replies: [RepliesItem]
}

public struct RepliesItem: Decodable {
    public let id: String
    public let username: String
    public let content: String
}

extension ReplyListDTO {
    func toDomain() -> ReplyListEntity {
        return ReplyListEntity(replies: replies.map { item in
                .init(
                    id: item.id,
                    userName: item.username,
                    content: item.content
                )
        })
    }
}
