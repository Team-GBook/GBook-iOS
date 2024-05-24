import Moya
import Domain
import Foundation
import Core

public enum BooksAPI {
    case searchBooks(keyword: String)
    case fetchBestSeller
    case likeBook(isbn: String)
    case fetchDetailBook(isbn: String)
    case fetchReviews(isbn: String)
    case writeReview(isbn: String, request: ReviewWriteRequest)
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
        case .fetchDetailBook(let isbn):
            return "books/details/\(isbn)"

        case .fetchReviews(let isbn):
            return "/reviews/\(isbn)"

        case .writeReview(let isbn, _):
            return "/reviews/\(isbn)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .searchBooks,
            .fetchBestSeller,
            .fetchDetailBook,
            .fetchReviews:
            return .get
        case .likeBook:
            return .put
        case .writeReview:
            return .post
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
        case .writeReview(_, let request):
            return .requestJSONEncodable(request)
        default:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        return TokenStorage.shared.toHeader(.accessToken)
    }
}
