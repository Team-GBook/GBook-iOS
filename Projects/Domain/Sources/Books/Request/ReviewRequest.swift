import Foundation

public struct ReviewRequest: Encodable {
    public let title: String
    public let review: String
    public let reconstruction: String
    public let analysis: String
    public let genre: String

    public init(title: String, review: String, reconstruction: String, analysis: String, genre: String) {
        self.title = title
        self.review = review
        self.reconstruction = reconstruction
        self.analysis = analysis
        self.genre = genre
    }
}
