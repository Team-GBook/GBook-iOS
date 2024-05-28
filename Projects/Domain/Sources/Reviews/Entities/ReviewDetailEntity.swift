import Foundation

public struct ReviewDetailEntity {
    public let id: String
    public let isbn: String
    public let title: String
    public let user: String
    public let review: String
    public let reconstruction: String
    public let analysis: String
    public let isMine: Bool
    public let createdAt: String

    public init(
        id: String,
        isbn: String,
        title: String,
        user: String,
        review: String,
        reconstruction: String,
        analysis: String,
        isMine: Bool,
        createdAt: String
    ) {
        self.id = id
        self.isbn = isbn
        self.title = title
        self.user = user
        self.review = review
        self.reconstruction = reconstruction
        self.analysis = analysis
        self.isMine = isMine
        self.createdAt = createdAt
    }
}
