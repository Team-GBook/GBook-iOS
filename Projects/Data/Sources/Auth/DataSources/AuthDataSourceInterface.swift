import Foundation
import Moya
import RxSwift

public protocol AuthDataSourceInterface {
    func login(email: String, password: String) -> Single<TokenDTO>
    func sendEmail(email: String) -> Completable
    func fetchUserProfile() -> Single<Response>
    func editUserProfile(nickName: String, genre: String) -> Completable
    func uploadProfile(imageData: Data) -> Completable
    func emailCheck(email: String, code: Int) -> Completable
    func signup(
        email: String,
        password: String,
        nickName: String,
        genre: String
    ) -> Completable
}
