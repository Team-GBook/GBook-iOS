import Foundation
import UIKit
import RxFlow
import RxSwift
import RxCocoa
import Core
import Domain

public class ReviewCommentViewModel: ViewModelType, Stepper {
    public var steps = RxRelay.PublishRelay<RxFlow.Step>()
    public var disposeBag = DisposeBag()

    public struct Input {
        
    }
    public struct Output {
        
    }
    public func transform(input: Input) -> Output {

        return Output(
        
        )
    }
}
