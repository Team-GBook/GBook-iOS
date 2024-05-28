import Domain

public struct ReviewsDI {
    public static let shared = Self.resolve()

    public let patchReviewUseCase: PatchReviewUseCase
    public let deleteReviewUseCase: DeleteReviewUseCase
    public let fetchDetailUseCase: FetchDetailReviewUseCase
    
}

extension ReviewsDI {
    static func resolve() -> ReviewsDI {
        let reviewsRepositoryImpl = ReviewsRepositoryImpl()

        let patchReviewUseCase = PatchReviewUseCase(repository: reviewsRepositoryImpl)
        let deleteReviewUseCase = DeleteReviewUseCase(repository: reviewsRepositoryImpl)
        let fetchDetailUseCase = FetchDetailReviewUseCase(repository: reviewsRepositoryImpl)

        return .init(
            patchReviewUseCase: patchReviewUseCase, 
            deleteReviewUseCase: deleteReviewUseCase,
            fetchDetailUseCase: fetchDetailUseCase
        )
    }
}
