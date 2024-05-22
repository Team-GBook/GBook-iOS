import Moya
import Foundation
import Core

public enum BooksAPI {
    case searchBooks(keyword: String)
    case fetchBestSeller
    case likeBook(isbn: String)
}

extension BooksAPI: TargetType {
    public var baseURL: URL {
        return BaseURL.baseURL
    }
    
    public var path: String {
        switch self {
        case .searchBooks(let keyword):
            return "/books/search/\(keyword)"
        case .fetchBestSeller:
            return "/books/bestSeller"
        case .likeBook(let isbn):
            return "/books/like/\(isbn)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .searchBooks, .fetchBestSeller:
            return .get
        case .likeBook:
            return .put
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .searchBooks:
            return .requestParameters(
                parameters: [
                    "start": 1
                ], encoding: URLEncoding.queryString)
        case .fetchBestSeller:
            return .requestParameters(
                parameters: [
                    "start": 1
                ], encoding: URLEncoding.queryString)
        case .likeBook:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        return TokenStorage.shared.toHeader(.accessToken)
    }
}
