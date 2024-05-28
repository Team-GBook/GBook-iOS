import UIKit
import SnapKit
import Then
import DesignSystem
import Domain
import RxSwift
import Kingfisher
import Core

protocol BookReviewStackViewCellDelegate: AnyObject {
    func commentButtonDidTapped(id: String)
}
class BookReviewStackViewCell: BaseView<BookReviewElement> {
    var disposeBag = DisposeBag()
    var isbn: String = ""
    var id: String = ""
    weak var delegate: BookReviewStackViewCellDelegate?
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
    private let commentButton = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "comment"), for: .normal)
        $0.setImageTintColor(.black)
        $0.setTitle("0", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.setImageInset(intervalSpacing: 8)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        $0.titleLabel?.textColor = .black
    }
    private let heartButton = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "like"), for: .normal)
        $0.setImageTintColor(.black)
        $0.setTitle("0", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.setImageInset(intervalSpacing: 8)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        $0.titleLabel?.textColor = .black
    }
    private lazy var buttonStackView = UIStackView(arrangedSubviews: [
        commentButton,
        heartButton
    ]).then {
        $0.axis = .vertical
        $0.spacing = 8
    }

    override func initalize() {
        commentButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.delegate?.commentButtonDidTapped(id: self?.id ?? "" )
            })
            .disposed(by: disposeBag)
    }
    override func configure(with item: BookReviewElement) {
        self.id = item.id
        self.titleLabel.text = item.title
        self.userLabel.text = item.user
        self.dateLabel.text = item.createdAt
        self.commentButton.setTitle("\(item.commentCount)", for: .normal)
        self.heartButton.setTitle("\(item.likeCount)", for: .normal)
    }
    override func addView() {
        addSubview(cellBackgroundView)
        [
            commentStackView,
            buttonStackView
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
        buttonStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
}
