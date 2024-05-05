import Foundation
import Moya
import RxSwift

public protocol AuthDataSourceInterface {
    func login(email: String, password: String) -> Single<TokenDTO>
    func sendEmail(email: String) -> Completable
    func emailCheck(email: String, code: Int) -> Completable
    func signup(
        email: String,
        password: String,
        nickName: String,
        genre: String
    ) -> Completable
}
