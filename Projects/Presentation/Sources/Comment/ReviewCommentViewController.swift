import UIKit
import SnapKit
import Then
import DesignSystem
import RxSwift
import RxCocoa

public class ReviewCommentViewController: UIViewController {

    private let viewWillAppear = PublishRelay<Void>()
    private let commentTableView = UITableView().then {
        $0.register(ReviewCommentCell.self, forCellReuseIdentifier: ReviewCommentCell.identifier)
        $0.rowHeight = 132
    }

    
}
