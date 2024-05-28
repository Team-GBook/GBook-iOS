import Foundation
import RxSwift

public protocol AuthRepositoryInterface {
    func login(email: String, password: String) -> Completable
    func sendEmail(email: String) -> Completable
    func fetchUserProfile() -> Single<UserEntity>
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
