import Foundation
import RxSwift

public protocol AuthRepositoryInterface {
    func login(email: String, password: String) -> Completable
    func sendEmail(email: String) -> Completable
    func emailCheck(email: String, code: Int) -> Completable
    func signup(
        email: String,
        password: String,
        nickName: String,
        genre: String
    ) -> Completable
}
