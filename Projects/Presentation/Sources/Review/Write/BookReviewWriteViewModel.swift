import Foundation
import UIKit
import RxFlow
import RxSwift
import RxCocoa
import Core
import Domain
import DesignSystem

public class BookReviewWriteViewModel: ViewModelType, Stepper {
    public var isbn: String = ""
    public var steps = RxRelay.PublishRelay<RxFlow.Step>()
    public var disposeBag = DisposeBag()
    private let fetchDetailBookUseCase: FetchDetailBookUseCase
    private let writeReviewUseCase: WriteReviewUseCase

    public init(
        fetchDetailBookUseCase: FetchDetailBookUseCase,
        writeReviewUseCase: WriteReviewUseCase
    ) {
        self.fetchDetailBookUseCase = fetchDetailBookUseCase
        self.writeReviewUseCase = writeReviewUseCase
    }

    public struct Input {
        let viewWillAppear: Observable<Void>
        let writeButtonDidTap: Signal<Void>
        let titleText: Driver<String>
        let reviewText: Driver<String>
        let reconstructionText: Driver<String>
        let analysisText: Driver<String>
        let genre: Driver<Genre>
    }
    public struct Output {
        let bookDetail: Signal<BookDetailsEntity>
    }
    public func transform(input: Input) -> Output {
        let booksDetail = PublishRelay<BookDetailsEntity>()
        let info = Driver.combineLatest(input.titleText, input.reviewText, input.reconstructionText, input.analysisText, input.genre)

        input.viewWillAppear.asObservable()
            .flatMap { _ in
                self.fetchDetailBookUseCase.excute(isbn: self.isbn)
            }
            .bind(to: booksDetail)
            .disposed(by: disposeBag)

        input.writeButtonDidTap.asObservable()
            .withLatestFrom(info)
            .flatMap {
                self.writeReviewUseCase.excute(
                    isbn: self.isbn,
                    request: .init(
                        title: $0.0,
                        review: $0.1,
                        reconstruction: $0.2,
                        analysis: $0.3,
                        genre: $0.4.eng
                    )
                )
                .andThen(Single.just(AppStep.popIsRequird))
            }
            .bind(to: steps)
            .disposed(by: disposeBag)

        return Output(bookDetail: booksDetail.asSignal())
    }
}
