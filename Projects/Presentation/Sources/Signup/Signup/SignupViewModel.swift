import Foundation
import RxFlow
import RxSwift
import RxCocoa
import Core
import Domain

public class SignupViewModel: ViewModelType, Stepper {

    public var steps = RxRelay.PublishRelay<RxFlow.Step>()
    private let signupUseCase: SignupUseCase
    private let disposeBag = DisposeBag()

    public init(signupUseCase: SignupUseCase) {
        self.signupUseCase = signupUseCase
    }

    public struct Input {
        let nameText: Observable<String>
        let passwordText: Observable<String>
        let passwordCheckText: Observable<String>
        let email: String
        let signupButtonDidTapped: Observable<Void>
    }
    public struct Output { }
    public func transform(input: Input) -> Output {
        let info = Observable.combineLatest(
            input.nameText,
            input.passwordText,
            input.passwordCheckText
        )
        input.signupButtonDidTapped
            .withLatestFrom(info)
            .flatMap { name, password, passwordCheck in
                self.signupUseCase.excute(
                    email: input.email,
                    password: password,
                    nickName: name,
                    genre: "NOVEL"
                )
                .andThen(Single.just(AppStep.successSignup))
            }
            .bind(to: steps)
            .disposed(by: disposeBag)
        
        return Output()
    }
}
