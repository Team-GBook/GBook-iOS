import Foundation
import UIKit
import RxFlow
import RxSwift
import RxCocoa
import Core
import Domain

public class ReviewCommentViewModel: ViewModelType, Stepper {

    public var reviewId: String = ""
    public var isbn: String = ""
    public var steps = RxRelay.PublishRelay<RxFlow.Step>()
    public var disposeBag = DisposeBag()
    private let fetchReviewCommentUseCase: FetchReviewCommentUseCase
    private let writeCommentUseCase: WriteCommentUseCase

    public init(
        fetchReviewCommentUseCase: FetchReviewCommentUseCase,
        writeCommentUseCase: WriteCommentUseCase
    ) {
        self.fetchReviewCommentUseCase = fetchReviewCommentUseCase
        self.writeCommentUseCase = writeCommentUseCase
    }

    public struct Input {
        let viewWillAppear: Observable<Void>
        let commentTableViewCellDidTap: Observable<CommentElement>
        let commentText: Observable<String>
        let sendButtonDidTapped: Observable<Void>
    }
    public struct Output {
        let commentList: Signal<[CommentElement]>
    }
    public func transform(input: Input) -> Output {
        let commentList = PublishRelay<[CommentElement]>()
        input.viewWillAppear.asObservable()
            .flatMap {
                self.fetchReviewCommentUseCase.excute(reviewId: self.reviewId)
                    .map { $0.comments }
            }
            .bind(to: commentList)
            .disposed(by: disposeBag)

        input.commentTableViewCellDidTap.asObservable()
            .map { AppStep.reviewReplyIsRequired(
                commentId: $0.id,
                userName: $0.userName,
                content: $0.content,
                replyCount: $0.replyCount
            ) }
            .bind(to: steps)
            .disposed(by: disposeBag)

        input.sendButtonDidTapped
            .withLatestFrom(input.commentText)
            .flatMap { comment in
                self.writeCommentUseCase.excute(reviewId: self.reviewId, comment: comment)
            }
            .subscribe()
            .disposed(by: disposeBag)
        return Output(commentList: commentList.asSignal())
    }
}
