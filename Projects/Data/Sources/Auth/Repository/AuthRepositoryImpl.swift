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
                    print(tokens.accessToken)
                    TokenStorage.shared.accessToken = tokens.accessToken
                    TokenStorage.shared.refreshToken = tokens.refreshToken
                    completable(.completed)
                }, onFailure: { error in
                    print("askfnjqnjnwjn")
//                    completable(.error(error))
                    print(error)
                })
            return Disposables.create {
                disposable?.dispose()
            }
        }
    }
    
    public func sendEmail(email: String) -> RxSwift.Completable {
        return dataSource.sendEmail(email: email)
    }

    public func fetchUserProfile() -> RxSwift.Single<Domain.UserEntity> {
        return dataSource.fetchUserProfile()
            .map(UserDTO.self)
            .map { $0.toDomain() }
    }
    
    public func editUserProfile(nickName: String, genre: String) -> RxSwift.Completable {
        return dataSource.editUserProfile(nickName: nickName, genre: genre)
    }
    
    public func uploadProfile(imageData: Data) -> RxSwift.Completable {
        return dataSource.uploadProfile(imageData: imageData)
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
