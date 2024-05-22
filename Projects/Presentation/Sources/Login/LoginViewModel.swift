import Foundation
import Domain
import Core
import RxSwift
import RxCocoa
import RxFlow

public class LoginViewModel: ViewModelType, Stepper {
    
    public var steps = RxRelay.PublishRelay<RxFlow.Step>()
    private let loginUseCase: LoginUseCase
    private var disposeBag = DisposeBag()
    
    public init(loginUseCase: LoginUseCase) {
        self.loginUseCase = loginUseCase
    }
    
    public struct Input {
        let emailText: Observable<String>
        let passwordText: Observable<String>
        let loginButtonDidTapped: Observable<Void>
    }
    public struct Output {
    }
    public func transform(input: Input) -> Output {
        let info = Observable.combineLatest(
            input.emailText,
            input.passwordText
        )
        input.loginButtonDidTapped
            .withLatestFrom(info)
            .flatMap { email, password in
                self.loginUseCase.excute(email: email, password: password)
                    .andThen(Single.just(AppStep.homeIsRequired))
//                    .catchAndReturn(AppStep.error)
            }
            .bind(to: steps)
            .disposed(by: disposeBag)
        return Output()
    }
}
