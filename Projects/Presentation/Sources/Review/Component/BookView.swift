import UIKit
import SnapKit
import Then
import DesignSystem
import Domain
import Core
import Kingfisher

public class BookView: BaseView<BookDetailsEntity> {

    private let bookImageView = UIImageView().then {
        $0.clipsToBounds = true
    }
    private let bookTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.numberOfLines = 4
    }
    private let authorLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.textColor = .onSurface
    }
    private let publisherLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.textColor = .onSurface
    }
    private lazy var bookTitleStackView  = UIStackView(arrangedSubviews: [
        bookTitleLabel,
        authorLabel,
        publisherLabel
    ]).then {
        $0.axis = .vertical
        $0.spacing = 4
        $0.distribution = .fill
        $0.alignment = .fill
    }

    public override func configure(with item: BookDetailsEntity) {
        bookImageView.kf.setImage(with: URL(string: item.cover))
        bookTitleLabel.text = item.title
        authorLabel.text = item.author
        publisherLabel.text = item.publisher
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
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalTo(bookImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(20)
        }
        
    }

}
