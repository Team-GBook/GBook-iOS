import Moya
import Domain
import Foundation
import Core

public enum ReviewsAPI {
    case writeReview(isbn: String, request: ReviewRequest)
    case patchReview(isbn: String, request: ReviewRequest)
    case deleteReview(isbn: String)
    case fetchReviews(isbn: String)
    case fetchDetailReviews(reviewId: String)
}

extension ReviewsAPI: TargetType {
    public var baseURL: URL {
        return BaseURL.baseURL
    }
    
    public var path: String {
        switch self {
        case .writeReview(let isbn, _):
            return "/reviews/\(isbn)"
        case .patchReview(let isbn, _):
            return "reviews/\(isbn)"
        case .deleteReview(let isbn):
            return "reviews/\(isbn)"
        case .fetchReviews(let isbn):
            return "/reviews/\(isbn)"
        case .fetchDetailReviews(let reviewId):
            return "/reviews/details/\(reviewId)"

        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .writeReview:
            return .post
        case .patchReview:
            return .patch
        case .deleteReview:
            return .delete
        case .fetchReviews,
             .fetchDetailReviews:
            return .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .writeReview(_, let request):
            return .requestJSONEncodable(request)
        case .patchReview(_, let request):
            return .requestJSONEncodable(request)
        default:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        return TokenStorage.shared.toHeader(.accessToken)
    }
}
