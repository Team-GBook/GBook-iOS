import UIKit
import SnapKit
import Then
import DesignSystem
import RxCocoa
import RxSwift

public class BookReviewEditViewController: UIViewController {
    private let disposeBag = DisposeBag()
    public var isbn: String = ""
    private let selectedGenre = PublishRelay<Genre>()
    private let viewDidAppear = PublishRelay<Void>()
    public let viewModel: BookReviewEditViewModel
    public init(viewModel: BookReviewEditViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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
    private let titleInfoView = ReviewInfoView(
        title: "제목",
        placeholder: "독후감의 제목을 적어주세요.",
        textViewHeight: 150
    )
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
        title: "감상평",
        placeholder: "감상평을 남겨주세요.",
        textViewHeight: 150
    )
    private let genreStackView = GenreStackView().then {
        $0.setGenre()
    }
    private let reviewWriteButton = GBButton(type: .system).then {
        $0.setTitle("수정", for: .normal)
    }
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addView()
        setLayout()
    }
    private func bind() {
        let input = BookReviewEditViewModel.Input(
            viewWillAppear: viewDidAppear.asObservable(),
            editButtonDidTap: reviewWriteButton.rx.tap.asSignal(),
            titleText: titleInfoView.textView.rx.text.orEmpty.asDriver(),
            reviewText: reviewInfoView.textView.rx.text.orEmpty.asDriver(),
            reconstructionText: reconstructionInfoView.textView.rx.text.orEmpty.asDriver(),
            analysisText: reviewInfoView.textView.rx.text.orEmpty.asDriver(),
            genre: selectedGenre.asDriver(onErrorJustReturn: .biography)
        )
    
        let output = viewModel.transform(input: input)
        output.bookDetail.asObservable()
            .subscribe(onNext: {[weak self] items in
                self?.bookView.configure(with: items)
            })
            .disposed(by: disposeBag)
    }
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bind()
        self.viewDidAppear.accept(())
        genreStackView.genreDidTap = {
            self.selectedGenre.accept($0)
        }
        selectedGenre.asObservable()
            .distinctUntilChanged()
            .bind {
                self.genreStackView.updateGenre($0)
            }
            .disposed(by: disposeBag)
    }
    
}

extension BookReviewEditViewController {
    private func addView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        [
            stackView,
            reviewWriteButton
        ].forEach(contentView.addSubview(_:))
 
        [
            bookView,
            titleInfoView,
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
