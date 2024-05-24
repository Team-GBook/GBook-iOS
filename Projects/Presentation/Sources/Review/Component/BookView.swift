import UIKit
import SnapKit
import Then
import DesignSystem
import Domain
import Core
import Kingfisher

public class BookView: BaseView<Book> {

    private let bookImageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.borderWidth = 1
    }

    private let bookTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    private let authorLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.textColor = .onSurface
    }
    private let publisherLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.textColor = .onSurface
    }

    private let reviewCountView = CountView(image: DesignSystemAsset.Assets.document.image)
    private let likeCountView = CountView(image: DesignSystemAsset.Assets.like.image)

    private let bookTitleStackView  = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 4
    }
    private let countStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
    }
    

    public override func configure(with item: Book) {
        bookImageView.kf.setImage(with: URL(string: item.cover))
        bookTitleLabel.text = item.title
        authorLabel.text = item.author
        publisherLabel.text = item.publisher
        reviewCountView.setCount(count: item.reviewCount)
        likeCountView.setCount(count: item.likeCount)
    }

    public override func addView() {
        [
            bookImageView,
            bookTitleStackView,
            countStackView
        ].forEach { addSubview($0) }
        [
            bookTitleLabel,
            authorLabel,
            publisherLabel
        ].forEach(self.bookTitleStackView.addArrangedSubview(_:))
        [
            reviewCountView,
            likeCountView
        ].forEach(self.countStackView.addArrangedSubview(_:))
    }
    public override func setLayout() {
        bookImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(92)
            $0.height.equalTo(141)
        }
        bookTitleStackView.snp.makeConstraints {
            $0.top.equalTo(bookImageView.snp.top)
            $0.leading.equalTo(bookImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(20)
        }
        countStackView.snp.makeConstraints {
            $0.bottom.equalTo(bookImageView.snp.bottom)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(56)
        }
    }

}
