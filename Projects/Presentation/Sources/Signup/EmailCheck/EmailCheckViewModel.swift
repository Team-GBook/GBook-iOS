import Foundation
import RxFlow
import RxSwift
import RxCocoa
import Core
import Domain

public class EmailCheckViewModel: ViewModelType, Stepper {

    public var steps = RxRelay.PublishRelay<RxFlow.Step>()
    private let emailCheckUseCase: EmailCheckUseCase
    private let disposeBag = DisposeBag()

    public init(emailCheckUseCase: EmailCheckUseCase) {
        self.emailCheckUseCase = emailCheckUseCase
    }

    public struct Input {
        let firstCode: Observable<String>
        let secondCode: Observable<String>
        let thirdCode: Observable<String>
        let fourthCode: Observable<String>
        let email: String
        let completeButtonDidTapped: Observable<Void>
    }
    public struct Output { }
    public func transform(input: Input) -> Output {
        let info = Observable.combineLatest(
            input.firstCode,
            input.secondCode,
            input.thirdCode,
            input.fourthCode
        ) { first,second,third,fourth  in
            return "\(first)\(second)\(third)\(fourth)"
        }
        input.completeButtonDidTapped
            .withLatestFrom(info)
            .flatMap { code in
                self.emailCheckUseCase.excute(email: input.email, code: Int(code)!)
                    .andThen(Single.just(AppStep.signupIsRequired(email: input.email)))
//                    .catch { _ in
//                        Single.just(AppStep.successSignup)
//                    }
            }
            .bind(to: steps)
            .disposed(by: disposeBag)
        return Output()
    }
}
