import UIKit
import SnapKit
import Then
import DesignSystem
import RxSwift
import RxCocoa

public class BookDetailViewController: UIViewController {
    
    private let backgroundView = UIView()
    private let scrollView = UIScrollView()
    private let bookView = BookView()
    private let disposeBag = DisposeBag()
    private let viewWillAppear = PublishRelay<String>()
    public let viewModel: BookDetailViewModel
    public var isbn: String?
    
    private let descriptionTitleLabel = UILabel().then {
        $0.text = "줄거리"
        $0.font = .systemFont(ofSize: 20, weight: .medium)
    }
    private let descriptionLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.numberOfLines = 0
    }
    private let reviewtitleLabel = UILabel().then {
        $0.text = "독후감"
        $0.font = .systemFont(ofSize: 20, weight: .medium)
    }
    private let reviewTableView = UITableView().then {
        $0.rowHeight = 117
        $0.register(
            BookReviewTableViewCell.self,
            forCellReuseIdentifier: BookReviewTableViewCell.cellIdentifier
        )
        $0.isScrollEnabled = false
    }
    private let reviewWriteButton = GBButton(type: .system).then {
        $0.setTitle("독후감 작성", for: .normal)
    }
    
    public init(viewModel: BookDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addView()
        setLayout()
        bind()
    }
    public override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        viewWillAppear.accept(isbn ?? "")
    }
    
    private func bind() {
        let input = BookDetailViewModel.Input(
            viewWillAppear: viewWillAppear.asObservable()
        )
        let output = viewModel.transform(input: input)
        output.bookDetail.asObservable()
            .subscribe(onNext: {[weak self] items in
                self?.bookView.configure(with: items)
                self?.descriptionLabel.text = items.description
            })
            .disposed(by: disposeBag)
        output.reviewList.asObservable()
            .bind(to: reviewTableView.rx.items(
                cellIdentifier: BookReviewTableViewCell.cellIdentifier,
                cellType: BookReviewTableViewCell.self)
            ) { row, items, cell in
                cell.configure(with: items)
            }
            .disposed(by: disposeBag)
    }
    private func addView() {
        [
            reviewWriteButton,
            scrollView
        ].forEach { view.addSubview($0) }
        scrollView.addSubview(backgroundView)
        [
            bookView,
            descriptionTitleLabel,
            descriptionLabel,
            reviewtitleLabel,
            reviewWriteButton,
            reviewTableView
        ].forEach { backgroundView.addSubview($0) }
    }
    private func setLayout() {
        scrollView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(reviewWriteButton.snp.top)
        }
        backgroundView.snp.makeConstraints {
            $0.top.width.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        bookView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(173)
        }
        descriptionTitleLabel.snp.makeConstraints {
            $0.top.equalTo(bookView.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(24)
            $0.height.equalTo(24)
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionTitleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(21)
            $0.height.equalTo(144)
        }
        reviewtitleLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(24)
            $0.height.equalTo(24)
        }
        reviewTableView.snp.makeConstraints {
            $0.top.equalTo(reviewtitleLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
//            $0.bottom.equalToSuperview().offset(-16)
//            $0.height.greaterThanOrEqualTo(reviewTableView.contentSize.height + 5)
            $0.height.equalTo(800)
        }
        reviewWriteButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
    }
    
}
