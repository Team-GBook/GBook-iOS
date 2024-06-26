import UIKit
import SnapKit
import Then
import DesignSystem
import Domain
import RxSwift
import Kingfisher
import Core

class ReviewCommentCell: BaseTableViewCell<CommentElement> {

    private var commentId: String = ""
    static let identifier = "ReviewCommentCell"
    private let userImageView = UIImageView().then {
        $0.image = DesignSystemAsset.Assets.person.image
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
        $0.numberOfLines = 3
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
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = .init(top: 16, left: 21, bottom: 16, right: 21)
        $0.alignment = .leading
    }
    override func configure(with item: CommentElement) {
        self.selectionStyle = .none
        commentId = item.id
        userNameLabel.text = item.userName
        contentLabel.text = item.content
        replyButton.setTitle("추가 댓글 \(item.replyCount)개", for: .normal)
    }
    override func addView() {
        self.contentView.addSubview(commentStackView)
    }
    override func setLayout() {
        commentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        userImageView.snp.makeConstraints {
            $0.width.height.equalTo(28)
        }
    }
}
