import UIKit
import SnapKit
import Then
import DesignSystem
import Domain
import Core

public class BookView: BaseView<Book> {

    private let bookImageView = UIImageView().then {
        $0.clipsToBounds = true
    }
    private let bookTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    private let writerLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.textColor = .onSurface
    }
    private let publisherLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.textColor = .onSurface
    }
    private lazy var bookTitleStackView  = UIStackView(arrangedSubviews: [
        bookTitleLabel,
        writerLabel,
        publisherLabel
    ]).then {
        $0.axis = .vertical
    }

    public override func addView() {
        [
            bookImageView,
            bookTitleStackView
        ].forEach { addSubview($0) }
    }
    public override func setLayout() {
        bookImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(92)
        }
        bookTitleStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(16)
            $0.leading.equalTo(bookImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(20)
        }
    }

}
