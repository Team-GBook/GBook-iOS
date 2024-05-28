import Foundation
import UIKit
import RxFlow
import RxSwift
import RxCocoa
import Core
import Domain

public class ProfileEditViewModel: ViewModelType, Stepper {
    
    public var steps = RxRelay.PublishRelay<RxFlow.Step>()
    public var disposeBag = DisposeBag()
    private let uploadUserProfileUseCase: UploadUserProfileUseCase
    private let editUserProfileUseCase: EditUserProfileUseCase

    public init(
        uploadUserProfileUseCase: UploadUserProfileUseCase,
        editUserProfileUseCase: EditUserProfileUseCase
    ) {
        self.uploadUserProfileUseCase = uploadUserProfileUseCase
        self.editUserProfileUseCase = editUserProfileUseCase
    }
    public struct Input {
        let editButtonDidTapped: Observable<Void>
        let imageChangeButtonDidTapped: Observable<Data>
        let nameText: Observable<String>
//        let profileImage: Observable<Data>
    }
    public struct Output {
    }
    public func transform(input: Input) -> Output {
//        let info = Observable.combineLatest(input.nameText)
        input.imageChangeButtonDidTapped
            .flatMap { image in
                self.uploadUserProfileUseCase.excute(imageData: image)
            }
            .subscribe()
            .disposed(by: disposeBag)
        input.editButtonDidTapped
            .withLatestFrom(input.nameText)
            .flatMap { name in
                self.editUserProfileUseCase.excute(nickName: name, genre: "COMICS")
            }
            .subscribe()
            .disposed(by: disposeBag)
        
        return Output(
        )
    }
}
