import Foundation

public struct ReviewEntity {
    public let reviewList: [ReviewElement]
}

public struct ReviewElement {
    public let isbn: String
    public let title: String
}
