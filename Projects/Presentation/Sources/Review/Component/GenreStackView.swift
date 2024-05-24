import UIKit
import SnapKit
import Then
import RxGesture
import RxSwift
import DesignSystem

class GenreStackView: UIView {
    private let disposeBag = DisposeBag()
    public var genreDidTap: ((Genre) -> Void)?
    private let titleLabel = UILabel().then {
        $0.text = "이 책의 장르를 선택해주세요."
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
    func setGenre() {
        Genre.allCases.forEach { data in
            let genreStackViewCell = GenreStackViewCell(genre: data)
            genreStackViewCell.rx.tapGesture()
                .when(.recognized)
                .bind { _ in
                    self.genreDidTap?(genreStackViewCell.genre)
                }
                .disposed(by: disposeBag)
    
            self.backStackView.addArrangedSubview(genreStackViewCell)
        }
    }

    func updateGenre(_ genre: Genre) {
        backStackView.arrangedSubviews.forEach {
            guard let cell = $0 as? GenreStackViewCell else { return }
            cell.isChecked = cell.genre == genre
        }
    }
}
