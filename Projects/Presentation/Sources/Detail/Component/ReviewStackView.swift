import UIKit
import Domain
import SnapKit
import Then

class ReviewStackView: UIView {
    public var reviewDidTap: ((String) -> Void)?

    private let titleLabel = UILabel().then {
        $0.text = "독후감"
        $0.font = .systemFont(ofSize: 20, weight: .medium)
    }
    private let backStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 0
    }
    override func layoutSubviews() {
        [
            titleLabel,
            backStackView
        ].forEach(self.addSubview(_:))
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(24)
        }

        backStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    func setReview(_ review: [BookReviewElement]) {
        self.backStackView.subviews.forEach {
            self.backStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }

        review.forEach { data in
            let bookReviewStackViewCell = BookReviewStackViewCell().then {
                $0.configure(with: data)
            }
            bookReviewStackViewCell.delegate = self
            self.backStackView.addArrangedSubview(bookReviewStackViewCell)
        }
    }
    
}

extension ReviewStackView: BookReviewStackViewCellDelegate {
    func commentButtonDidTapped(id: String) {
        self.reviewDidTap?(id)
    }
}
