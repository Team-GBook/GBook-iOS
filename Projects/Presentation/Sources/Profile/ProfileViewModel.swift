import Foundation
import UIKit
import RxFlow
import RxSwift
import RxCocoa
import Core
import Domain

public class ProfileViewModel: ViewModelType, Stepper {
    
    public var isbn: String = ""
    public var steps = RxRelay.PublishRelay<RxFlow.Step>()
    public var disposeBag = DisposeBag()
    private let fetchUserProfileUseCase: FetchUserProfileUseCase

    public init(fetchUserProfileUseCase: FetchUserProfileUseCase) {
        self.fetchUserProfileUseCase = fetchUserProfileUseCase
    }
    public struct Input {
        let viewWillAppear: Observable<Void>
        let profileEditButtonDidTapped: Observable<Void>
    }
    public struct Output {
        let userProfile: Signal<UserEntity>
    }
    public func transform(input: Input) -> Output {
        let userProfile = PublishRelay<UserEntity>()

        input.viewWillAppear
            .flatMap {
                self.fetchUserProfileUseCase.excute()
            }
            .bind(to: userProfile)
            .disposed(by: disposeBag)
        input.profileEditButtonDidTapped
            .map { AppStep.profileEditRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)
        return Output(
            userProfile: userProfile.asSignal()
        )
    }
}
