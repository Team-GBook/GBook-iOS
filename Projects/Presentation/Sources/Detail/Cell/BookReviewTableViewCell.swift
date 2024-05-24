import UIKit
import SnapKit
import Then
import DesignSystem
import Domain
import RxSwift
import Kingfisher
import Core

class BookReviewTableViewCell: BaseTableViewCell<BookReviewElement> {

    static let cellIdentifier: String = "BookReviewTableViewCell"
    var disposeBag = DisposeBag()
    var isbn: String = ""
    let cellBackgroundView = UIView()

    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .medium)
    }
    private let userLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.textColor = .onSurface
    }
    private let dateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.textColor = .onSurface
    }
    private lazy var commentStackView = UIStackView(arrangedSubviews: [
        titleLabel,
        userLabel,
        dateLabel
    ]).then {
        $0.axis = .vertical
    }

    override func configure(with item: BookReviewElement) {
        self.titleLabel.text = item.title
        self.userLabel.text = item.user
        self.dateLabel.text = item.createdAt
    }
    override func addView() {
        addSubview(cellBackgroundView)
        [
            commentStackView
        ].forEach { cellBackgroundView.addSubview($0) }
    }
    override func setLayout() {
        cellBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        commentStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.bottom.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(114)
        }
    }
}
