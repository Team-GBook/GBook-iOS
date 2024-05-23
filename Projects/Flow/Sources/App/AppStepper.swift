import RxFlow
import RxSwift
import RxCocoa
import Core

public class AppStepper: Stepper {
    public let steps = PublishRelay<Step>()

    public init() { }

    public func readyToEmitSteps() {
        steps.accept(AppStep.onboardingIsRequired)
    }
}
