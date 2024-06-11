import Foundation
import UIKit
import RxFlow
import RxSwift
import RxCocoa
import Core
import Domain

public class BookReviewDetailViewModel: ViewModelType, Stepper {
    
    public var reviewId: String = ""
    public var isbn: String = ""
    public var steps = RxRelay.PublishRelay<RxFlow.Step>()
    public var disposeBag = DisposeBag()

    private let fetchDetailBookUseCase: FetchDetailReviewUseCase
    private let patchReviewUseCase: PatchReviewUseCase
    private let deleteReviewUseCase: DeleteReviewUseCase

    public init(
        fetchDetailBookUseCase: FetchDetailReviewUseCase,
        editReviewUseCase: PatchReviewUseCase,
        deleteReviewUseCase: DeleteReviewUseCase
    ) {
        self.fetchDetailBookUseCase = fetchDetailBookUseCase
        self.patchReviewUseCase = editReviewUseCase
        self.deleteReviewUseCase = deleteReviewUseCase
    }

    public struct Input {
        let viewWillAppear: Observable<Void>
        let editIsRequired: Observable<String>
        let deleteIsRequired: Observable<String>
        let reviewCommentIsRequired: Observable<Void>
        let popToRootView: Observable<Void>
    }
    public struct Output {
        let reviewDetiail: Signal<ReviewDetailEntity>
        
    }
    public func transform(input: Input) -> Output {
        let reviewDetiail = PublishRelay<ReviewDetailEntity>()
        input.viewWillAppear
            .flatMap {
                self.fetchDetailBookUseCase.excute(reviewId: self.reviewId)
            }
            .bind(to: reviewDetiail)
            .disposed(by: disposeBag)
        input.editIsRequired
            .map { isbn in
                AppStep.bookReviewEditIsRequired(isbn: self.isbn)
            }
            .bind(to: steps)
            .disposed(by: disposeBag)
        input.deleteIsRequired
            .flatMap { isbn in 
                self.deleteReviewUseCase.excute(isbn: isbn)
                    .andThen(Single.just(AppStep.popIsRequird))
            }
            .bind(to: steps)
            .disposed(by: disposeBag)
        input.reviewCommentIsRequired
            .map {
                AppStep.reviewCommentIsRequired(reviewId: self.reviewId)
            }
            .bind(to: steps)
            .disposed(by: disposeBag)
        input.popToRootView
            .map {
                AppStep.popToRootView
            }
            .bind(to: steps)
            .disposed(by: disposeBag)

        return Output(
            reviewDetiail: reviewDetiail.asSignal()
        )
    }
}
