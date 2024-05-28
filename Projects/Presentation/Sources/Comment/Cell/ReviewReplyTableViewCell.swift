import UIKit
import SnapKit
import Then
import DesignSystem
import Domain
import RxSwift
import Kingfisher
import Core

class ReviewReplyTableViewCell: BaseTableViewCell<ReplyElement> {

    private let cellBackgroundView = UIView()
    static let identifier = "ReviewReplyTableViewCell"
    private var commentId: String = ""
    private let userImageView = UIImageView().then {
        $0.layer.cornerRadius = 14
    }
    private let userNameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .regular)
    }
    private lazy var userStackView = UIStackView(arrangedSubviews: [
        userImageView,
        userNameLabel
    ]).then {
        $0.axis = .horizontal
        $0.spacing = 4
    }
    private let contentLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .medium)
    }
    private let replyButton = UIButton(type: .system).then {
        $0.setTitle("추가 댓글", for: .normal)
        $0.setTitleColor(UIColor.primary50, for: .normal)
    }
    private lazy var commentStackView = UIStackView(arrangedSubviews: [
        userStackView,
        contentLabel,
        replyButton
    ]).then {
        $0.axis = .vertical
    }
    override func configure(with item: ReplyElement) {
        commentId = item.id
        userNameLabel.text = item.userName
        contentLabel.text = item.content
    }
    override func addView() {
        addSubview(cellBackgroundView)
        cellBackgroundView.addSubview(commentStackView)
    }
    override func setLayout() {
        commentStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(16)
            $0.leading.trailing.equalToSuperview().inset(21)
        }
    }
}
