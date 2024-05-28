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

    case fetchComment(reviewId: String)
    case writeComment(reviewId: String, comment: String)
    case fetchReply(commentId: String)
    case writeReply(commentId: String, comment: String)
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
            return "/reviews/\(isbn)"
        case .deleteReview(let isbn):
            return "/reviews/\(isbn)"
        case .fetchReviews(let isbn):
            return "/reviews/\(isbn)"
        case .fetchDetailReviews(let reviewId):
            return "/reviews/details/\(reviewId)"

        case .fetchComment(let reviewId):
            return "/reviews/comment/\(reviewId)"
        case .writeComment(let reviewId, _):
            return "/reviews/comment/\(reviewId)"
        case .fetchReply(let commentId):
            return "/reviews/reply/\(commentId)"
        case .writeReply(let commentId, _):
            return "/reviews/reply/\(commentId)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .writeReview,
            .writeComment,
            .writeReply:
            return .post
        case .patchReview:
            return .patch
        case .deleteReview:
            return .delete
        case .fetchReviews,
             .fetchDetailReviews,
             .fetchComment,
             .fetchReply:
            return .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .writeReview(_, let request):
            return .requestJSONEncodable(request)
        case .patchReview(_, let request):
            return .requestJSONEncodable(request)
        case .writeComment(_, let comment):
            return .requestParameters(
                parameters: [
                    "content": comment
                ], encoding: JSONEncoding.default)
        case .writeReply(_, let comment):
            return .requestParameters(
                parameters: [
                    "content": comment
                ], encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        return TokenStorage.shared.toHeader(.accessToken)
    }
}
