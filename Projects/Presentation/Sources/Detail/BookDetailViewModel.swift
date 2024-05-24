import Foundation
import UIKit
import RxFlow
import RxSwift
import RxCocoa
import Core
import Domain

public class BookDetailViewModel: ViewModelType, Stepper {

    public var steps = RxRelay.PublishRelay<RxFlow.Step>()
    public var disposeBag = DisposeBag()
    private let fetchDetailBookUseCase: FetchDetailBookUseCase
    private let fetchReviewUseCase: FetchReviewUseCase

    public init(
        fetchDetailBookUseCase: FetchDetailBookUseCase,
        fetchReviewUseCase: FetchReviewUseCase
    ) {
        self.fetchDetailBookUseCase = fetchDetailBookUseCase
        self.fetchReviewUseCase = fetchReviewUseCase
    }

    public struct Input {
        let viewWillAppear: Observable<String>
    }
    public struct Output {
        let bookDetail: Signal<BookDetailsEntity>
        let reviewList: Signal<[BookReviewElement]>
        
    }
    public func transform(input: Input) -> Output {
        let booksDetail = PublishRelay<BookDetailsEntity>()
        let reviewList = PublishRelay<[BookReviewElement]>()
        input.viewWillAppear
            .flatMap { isbn in
                self.fetchDetailBookUseCase.excute(isbn: isbn)
            }
            .bind(to: booksDetail)
            .disposed(by: disposeBag)
        input.viewWillAppear
            .flatMap { isbn in
                self.fetchReviewUseCase.excute(isbn: isbn)
                    .map { $0.reviewList }
            }
            .bind(to: reviewList)
            .disposed(by: disposeBag)
        return Output(
            bookDetail: booksDetail.asSignal(),
            reviewList: reviewList.asSignal()
        )
    }
}
