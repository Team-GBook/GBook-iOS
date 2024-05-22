import Foundation
import RxFlow
import RxSwift
import RxCocoa
import Core
import Domain

public class EmailInputViewModel: ViewModelType, Stepper {

    public var steps = RxRelay.PublishRelay<RxFlow.Step>()
    private let sendEmailUseCase: SendEmailUseCase
    private let disposeBag = DisposeBag()

    public init(sendEmailUseCase: SendEmailUseCase) {
        self.sendEmailUseCase = sendEmailUseCase
    }

    public struct Input {
        let emailText: Observable<String>
        let nextButtonDidTapped: Observable<Void>
    }
    public struct Output { }
    public func transform(input: Input) -> Output {
        input.nextButtonDidTapped
            .withLatestFrom(input.emailText)
            .flatMap { email in
                self.sendEmailUseCase.excute(email: email)
                    .andThen(Single.just(AppStep.emailCheckIsRequired(email: email)))
            }
            .bind(to: steps)
            .disposed(by: disposeBag)
        return Output()
    }
}
