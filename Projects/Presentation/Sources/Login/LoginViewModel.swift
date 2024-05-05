import SwiftUI
import Domain
import RxSwift

public class LoginViewModel: ObservableObject {

    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoginSuccess: Bool = false

    private let loginUseCase: LoginUseCase
    private let disposeBag: DisposeBag = DisposeBag()

    public init(loginUseCase: LoginUseCase) {
        self.loginUseCase = loginUseCase
    }

    func login() {
        loginUseCase.excute(email: email, password: password)
            .subscribe(onCompleted: { [weak self] in
                self?.isLoginSuccess = true
            })
            .disposed(by: disposeBag)
        
    }
}
