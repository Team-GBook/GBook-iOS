import UIKit
import SnapKit
import Then
import DesignSystem
import RxCocoa
import RxSwift

public class BookReviewWriteViewContler: UIViewController {
    private let disposeBag = DisposeBag()
    private let selectedGenre = PublishRelay<Genre>()
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    private let contentView = UIView()
    private let stackView = UIStackView().then {
        $0.axis = .vertical
    }
    private let backgroundView = UIView()
    private let bookView = BookView().then {
        $0.backgroundColor = .white
    }
    private let translateInfoView = ReviewInfoView(
        title: "해석",
        placeholder: "본인만의 해석을 적어주세요.",
        textViewHeight: 150
    )
    private let reconstructionInfoView = ReviewInfoView(
        title: "재구성",
        placeholder: "본인만의 사건을 재구성해주세요. (선택)",
        textViewHeight: 150
    )
    private let reviewInfoView = ReviewInfoView(
        title: "감성평",
        placeholder: "감상평을 남겨주세요.",
        textViewHeight: 150
    )
    private let genreStackView = GenreStackView().then {
        $0.setGenre()
    }
    private let reviewWriteButton = GBButton(type: .system).then {
        $0.setTitle("작성", for: .normal)
    }
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addView()
        setLayout()
    }
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        genreStackView.genreDidTap = {
            self.selectedGenre.accept($0)
        }
        selectedGenre.asObservable()
            .distinctUntilChanged()
            .bind {
                self.genreStackView.updateGenre($0)
            }
            .disposed(by: disposeBag)
        
        bookView.configure(with: .init(
            title: "asfd",
            author: "Asdf",
            isbn: "Asf",
            cover:"https://img-cdn.pixlr.com/image-generator/history/65bb506dcb310754719cf81f/ede935de-1138-4f66-8ed7-44bd16efc709/medium.webp",
            publisher: "Asf",
            reviewCount: 3,
            likeCount: 4,
            isLiked: false
        ))
    }
    
}

extension BookReviewWriteViewContler {
    private func addView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        [
            stackView,
            reviewWriteButton
        ].forEach(contentView.addSubview(_:))
 
        [
            bookView,
            translateInfoView,
            reconstructionInfoView,
            reviewInfoView,
            genreStackView
        ].forEach(stackView.addArrangedSubview(_:))

    }
    private func setLayout() {
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.width.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalToSuperview()
            $0.bottom.equalTo(reviewWriteButton.snp.bottom)
        }
        
        stackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        bookView.snp.makeConstraints {
            $0.height.equalTo(173)
        }
        reviewWriteButton.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(50)
            $0.height.equalTo(48)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
    }
}
