import Foundation
import UIKit
import RxFlow
import RxSwift
import RxCocoa
import Core
import Domain

public class HomeViewModel: ViewModelType, Stepper {
    
    public var steps = RxRelay.PublishRelay<RxFlow.Step>()
    public var disposeBag = DisposeBag()
    private let fetchBestSellerUseCase: FetchBestSellerUseCase
    private let likeBookUseCase: LikeBookUseCase

    public init(
        fetchBestSellerUseCase: FetchBestSellerUseCase,
        likeBookUseCase: LikeBookUseCase
    ) {
        self.fetchBestSellerUseCase = fetchBestSellerUseCase
        self.likeBookUseCase = likeBookUseCase
    }
    public struct Input {
        let searchButtonDidTapped: Observable<Void>
        let itemSelected: Observable<(String?, UIImage?, String?, String?, String?)>
        let likeAccept: Observable<String>
        let viewWillAppear: Observable<Void>
    }
    public struct Output {
        let books: Signal<[Book]>
    }
    public func transform(input: Input) -> Output {
        let books = PublishRelay<[Book]>()

        input.searchButtonDidTapped
            .map { AppStep.searchIsRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)
        input.viewWillAppear
            .flatMapLatest {
                self.fetchBestSellerUseCase.excute()
                    .map { $0.items }
            }
            .bind(to: books)
            .disposed(by: disposeBag)
        input.likeAccept
            .flatMap { isbn in
                self.likeBookUseCase.excute(isbn: isbn)
            }
            .subscribe()
            .disposed(by: disposeBag)
        input.itemSelected
            .flatMapLatest { isbn, image, title, author, publisher -> Observable<RxFlow.Step> in
                guard let isbn = isbn,
                      let image = image,
                      let title = title,
                      let author = author,
                      let publisher = publisher
                else { return .never()}
                   let step = AppStep.bookReviewIsRequired(bookImage: image, bookTitle: title, author: author, publisher: publisher)
                   return Observable.just(step)
               }
            .bind(to: steps)
            .disposed(by: disposeBag)
        return Output(books: books.asSignal())
    }
}
