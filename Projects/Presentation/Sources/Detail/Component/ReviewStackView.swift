import UIKit
import Domain
import SnapKit
import Then

class ReviewStackView: UIView {
    let genreStackViewCell = BookReviewStackViewCell()
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
        review.forEach { data in
//            let genreStackViewCell = BookReviewStackViewCell().then {
//                $0.configure(with: data)
//            }
            genreStackViewCell.configure(with: data)
            self.backStackView.addArrangedSubview(genreStackViewCell)
        }
    }
    
}
