import Foundation
import Domain

public struct ReviewDetailDTO: Decodable {
    let id: String
    let isbn: String
    let title: String
    let user: String
    let review: String
    let reconstruction: String
    let analysis: String
    let isMine: Bool
    let createdAt: String
}

extension ReviewDetailDTO {
    func toDomain() -> ReviewDetailEntity {
        return .init(
            id: id,
            isbn: isbn, 
            title: title,
            user: user,
            review: review,
            reconstruction: reconstruction,
            analysis: analysis,
            isMine: isMine,
            createdAt: createdAt
        )
    }
}
