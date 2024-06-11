import UIKit
import SnapKit
import Then
import DesignSystem
import Domain
import RxSwift
import Kingfisher
import Core

class ReplyTableViewCell: BaseTableViewCell<ReplyElement> {

    static let identifier = "ReplyTableViewCell"
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
    private lazy var commentStackView = UIStackView(arrangedSubviews: [
        userStackView,
        contentLabel
    ]).then {
        $0.axis = .vertical
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = .init(top: 16, left: 21, bottom: 16, right: 21)
        $0.alignment = .leading
    }
    override func configure(with item: ReplyElement) {
        userNameLabel.text = item.userName
        contentLabel.text = item.content
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
