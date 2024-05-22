import Foundation
import RxFlow
import RxSwift
import RxCocoa
import Core
import Domain

public class BookSearchViewModel: ViewModelType, Stepper {

    public var steps = RxRelay.PublishRelay<RxFlow.Step>()
    private let disposeBag = DisposeBag()
    private let searchBookUseCase: BookSearchUseCase
    private let likeBookUseCase: LikeBookUseCase

    public init(
        searchBookUseCase: BookSearchUseCase,
        likeBookUseCase: LikeBookUseCase
    ) {
        self.searchBookUseCase = searchBookUseCase
        self.likeBookUseCase = likeBookUseCase
    }

    public struct Input {
        let keywordText: Observable<String>
        let likeAccept: Observable<String>
    }
    public struct Output { 
        let searchBooks: Signal<[Book]>
    }
    public func transform(input: Input) -> Output {
        let searchBooks = PublishRelay<[Book]>()
        input.keywordText
            .filter { !$0.isEmpty }
            .flatMapLatest { keyword in
                self.searchBookUseCase.excute(keyword: keyword)
                    .map { $0.items }
            }
        
            .bind(to: searchBooks)
            .disposed(by: disposeBag)

        input.likeAccept
            .flatMap { isbn in
                self.likeBookUseCase.excute(isbn: isbn)
            }
            .subscribe()
            .disposed(by: disposeBag)
        return Output(searchBooks: searchBooks.asSignal())
    }
}
