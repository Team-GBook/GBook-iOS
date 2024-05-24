import UIKit
import SnapKit
import Then
import DesignSystem
import Domain
import RxSwift
import Kingfisher
import Core

class BookTableViewCell: BaseTableViewCell<Book> {

    static let cellIdentifier: String = "BookTableViewCell"
    var disposeBag = DisposeBag()
    var isbn: String = ""

    let cellBackgroundView = UIView()
    let bookImageView = UIImageView().then {
        $0.sizeToFit()
        $0.clipsToBounds = true
    }
    private let bookTitleLabel = UILabel().then {
        $0.text = "내가 죽기 일주일 전"
        $0.numberOfLines = 4
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    private let autherLabel = UILabel().then {
        $0.text = "서은채 저"
        $0.textColor = .onSurface
        $0.font = .systemFont(ofSize: 16, weight: .medium)
    }
    private let publisherLabel = UILabel().then {
        $0.text = "황금 가지"
        $0.textColor = .onSurface
        $0.font = .systemFont(ofSize: 16, weight: .medium)
    }
    private lazy var titleStackView = UIStackView(arrangedSubviews: [
        bookTitleLabel,
        autherLabel,
        publisherLabel
    ]).then {
        $0.axis = .vertical
        $0.spacing = 4
    }
    private let heartButton = UIButton(type: .system).then {
        $0.setImage(UIImage(systemName: "heart"), for: .normal)
        $0.tintColor = .black
    }
    private let heartCountLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .regular)
    }
//    lazy var likeStackView = UIStackView(arrangedSubviews: [heartButton, heartCountLabel]).then {
//        $0.axis = .horizontal
//        $0.spacing = 8
//    }
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        disposeBag = DisposeBag() 
//    }

    override func configure(with item: Book) {
        super.configure(with: item)
        self.bookTitleLabel.text = item.title
        self.autherLabel.text = item.author
        self.publisherLabel.text = item.publisher
        self.bookImageView.kf.setImage(with: URL(string: item.cover))
        self.isbn = item.isbn
        self.heartCountLabel.text = "\(item.likeCount)"

    }
    override func addView() {
        addSubview(cellBackgroundView)
        [
            bookImageView,
            titleStackView,
//            likeStackView
            heartButton,
            heartCountLabel
        ].forEach { cellBackgroundView.addSubview($0) }
    }
    override func setLayout() {
        cellBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        bookImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(82)
        }
        titleStackView.snp.makeConstraints {
            $0.top.equalTo(bookImageView)
            $0.leading.equalTo(bookImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(20)
        }
//        likeStackView.snp.makeConstraints {
//            $0.trailing.equalToSuperview().inset(20)
//            $0.bottom.equalToSuperview().inset(16)
//            $0.height.equalTo(24)
//        }
        
        heartCountLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(19)
            $0.height.equalTo(24)
        }
        heartButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(16)
            $0.trailing.equalTo(heartCountLabel.snp.leading).offset(-8)
            $0.width.equalTo(25)
            $0.height.equalTo(24)
        }
    }
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        cellBackgroundView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//        bookImageView.snp.makeConstraints {
//            $0.top.bottom.equalToSuperview().inset(16)
//            $0.leading.equalToSuperview().inset(20)
//            $0.width.equalTo(82)
//        }
//        titleStackView.snp.makeConstraints {
//            $0.top.equalTo(bookImageView)
//            $0.leading.equalTo(bookImageView.snp.trailing).offset(8)
//            $0.trailing.equalToSuperview().inset(20)
//        }
////        likeStackView.snp.makeConstraints {
////            $0.trailing.equalToSuperview().inset(20)
////            $0.bottom.equalToSuperview().inset(16)
////            $0.height.equalTo(24)
////        }
//        
//        heartCountLabel.snp.makeConstraints {
//            $0.bottom.equalToSuperview().inset(16)
//            $0.trailing.equalToSuperview().inset(20)
//            $0.width.equalTo(19)
//            $0.height.equalTo(24)
//        }
//        heartButton.snp.makeConstraints {
//            $0.bottom.equalToSuperview().inset(16)
//            $0.trailing.equalTo(heartCountLabel.snp.leading).offset(-8)
//            $0.width.equalTo(25)
//            $0.height.equalTo(24)
//        }
}
