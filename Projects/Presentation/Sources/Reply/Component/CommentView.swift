import UIKit
import SnapKit
import Then
import DesignSystem
import Domain
import RxSwift
import Kingfisher
import Core

class CommentView: UIView {
    private let userImageView = UIImageView().then {
        $0.image = DesignSystemAsset.Assets.person.image
    }
    private let userNameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 22, weight: .medium)
    }
    private lazy var userStackView = UIStackView(arrangedSubviews: [
        userImageView,
        userNameLabel
    ]).then {
        $0.axis = .horizontal
        $0.spacing = 4
    }
    private let contentLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 22, weight: .regular)
        $0.numberOfLines = 3
    }
    private let replyCountLabel = UILabel().then {
        $0.textColor = UIColor.primary50
    }
    private lazy var commentStackView = UIStackView(arrangedSubviews: [
        userStackView,
        contentLabel,
        replyCountLabel
    ]).then {
        $0.axis = .vertical
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = .init(top: 16, left: 21, bottom: 16, right: 21)
        $0.alignment = .leading
    }
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        addView()
        setLayout()
    }
    func configure(userName: String, content: String, replyCount: Int) {
        userNameLabel.text = userName
        contentLabel.text = content
        replyCountLabel.text = "추가 댓글 \(replyCount)개"
    }
    func addView() {
        self.addSubview(commentStackView)
    }
    func setLayout() {
        commentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        userImageView.snp.makeConstraints {
            $0.width.height.equalTo(28)
        }
    }
}
