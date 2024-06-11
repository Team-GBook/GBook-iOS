import Foundation
import UIKit
import RxFlow
import RxSwift
import RxCocoa
import Core
import Domain

public class ReplyViewModel: ViewModelType, Stepper {

    public var commentId: String = ""
    public var content: String = ""
    public var userName: String = ""
    public var replyCount: Int = 0
    public var steps = RxRelay.PublishRelay<RxFlow.Step>()
    public var disposeBag = DisposeBag()
    private let fetchReviewReplyUseCase: FetchReviewReplyUseCase
    private let writeReplyUseCase: WriteReplyUseCase

    public init(
        fetchReviewReplyUseCase: FetchReviewReplyUseCase,
        writeReplyUseCase: WriteReplyUseCase
    ) {
        self.fetchReviewReplyUseCase = fetchReviewReplyUseCase
        self.writeReplyUseCase = writeReplyUseCase
    }

    public struct Input {
        let viewWillAppear: Observable<Void>
        let commentText: Observable<String>
        let sendButtonDidTapped: Observable<Void>
    }
    public struct Output {
        let replyList: Signal<[ReplyElement]>
    }
    public func transform(input: Input) -> Output {
        let replyList = PublishRelay<[ReplyElement]>()
        input.viewWillAppear.asObservable()
            .flatMap {
                self.fetchReviewReplyUseCase.excute(commentId: self.commentId)
                    .map { $0.replies }
            }
            .bind(to: replyList)
            .disposed(by: disposeBag)
        input.sendButtonDidTapped
            .withLatestFrom(input.commentText)
            .flatMap { comment in
                self.writeReplyUseCase.excute(commentId: self.commentId, comment: comment)
            }
            .subscribe()
            .disposed(by: disposeBag)
        return Output(replyList: replyList.asSignal())
    }
}
