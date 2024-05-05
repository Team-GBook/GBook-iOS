import Foundation
import Domain
import RxSwift
import Core

public class AuthRepositoryImpl: AuthRepositoryInterface {
    
    let dataSource = AuthDataSourceImpl.shard

    public func login(email: String, password: String) -> Completable {
        return Completable.create { [weak self] completable in
            let disposable = self?.dataSource.login(email: email, password: password)
                .subscribe(onSuccess: { tokens in
                    TokenStorage.shared.accessToken = tokens.accessToken
                    TokenStorage.shared.refreshToken = tokens.refreshToken
                    completable(.completed)
                }, onFailure: { error in
                    completable(.error(error))
                })
            return Disposables.create {
                disposable?.dispose()
            }
        }
    }
    
    public func sendEmail(email: String) -> RxSwift.Completable {
        return dataSource.sendEmail(email: email)
    }
    
    public func emailCheck(email: String, code: Int) -> RxSwift.Completable {
        return dataSource.emailCheck(email: email, code: code)
    }
    
    public func signup(
        email: String,
        password: String,
        nickName: String,
        genre: String
    ) -> RxSwift.Completable {
        return dataSource.signup(
            email: email,
            password: password,
            nickName: nickName,
            genre: genre
        )
    }
}
