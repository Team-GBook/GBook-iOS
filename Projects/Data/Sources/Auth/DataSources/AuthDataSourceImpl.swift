import Foundation
import Domain
import Moya
import RxSwift
import RxMoya
import AppNetwork

public class AuthDataSourceImpl: AuthDataSourceInterface {

    private let provider = MoyaProvider<AuthAPI>(plugins: [MoyaLoggingPlugin()])
    public static let shard = AuthDataSourceImpl()

    public func login(email: String, password: String) -> RxSwift.Single<TokenDTO> {
        return provider.rx.request(.login(email: email, password: password))
            .filterSuccessfulStatusCodes()
            .map(TokenDTO.self)
    }
    public func sendEmail(email: String) -> Completable {
        return provider.rx.request(.sendEmail(email: email))
            .filterSuccessfulStatusCodes()
            .asCompletable()
    }
    
    public func emailCheck(email: String, code: Int) -> Completable {
        return provider.rx.request(.emailCheck(email: email, code: code))
            .filterSuccessfulStatusCodes()
            .asCompletable()
    }
    
    public func signup(
        email: String,
        password: String,
        nickName: String,
        genre: String
    ) -> Completable {
        return provider.rx.request(.signup(
            email: email,
            password: password,
            nickName: nickName,
            genre: genre
        ))
        .filterSuccessfulStatusCodes()
        .asCompletable()
    }
    public func fetchUserProfile() -> RxSwift.Single<Response> {
        return provider.rx.request(.fetchUserProfile)
            .filterSuccessfulStatusCodes()
    }
    
    public func editUserProfile(nickName: String, genre: String) -> RxSwift.Completable {
        return provider.rx.request(.editProfile(name: nickName))
            .filterSuccessfulStatusCodes()
            .asCompletable()
    }

    public func uploadProfile(imageData: Data) -> RxSwift.Completable {
        return provider.rx.request(.uploadImage(image: imageData))
            .filterSuccessfulStatusCodes()
            .asCompletable()
    }
}
