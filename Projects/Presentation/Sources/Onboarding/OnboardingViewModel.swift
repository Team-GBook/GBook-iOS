import Foundation
import RxFlow
import RxSwift
import RxCocoa
import Core

public class OnboardingViewModel: ViewModelType, Stepper {

    public init() { }
    public var steps = PublishRelay<Step>()
    private var disposeBag = DisposeBag()
    public struct Input {
        let loginButtonDidTapped: Observable<Void>
        let signupButtonDidTapped: Observable<Void>
    }
    public struct Output {
    }

    public func transform(input: Input) -> Output {
        input.loginButtonDidTapped
            .map { AppStep.loginIsRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)
        input.signupButtonDidTapped
            .map { AppStep.emailInputIsRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)
        return Output()
    }
    
}
