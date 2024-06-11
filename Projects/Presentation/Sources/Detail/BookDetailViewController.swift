import UIKit
import SnapKit
import Then
import DesignSystem
import RxSwift
import RxCocoa

public class BookDetailViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let backStackView = UIStackView().then {
        $0.spacing = 8
        $0.axis = .vertical
    }
    private let bookView = BookView()
    private let disposeBag = DisposeBag()
    private let viewWillAppear = PublishRelay<Void>()
    private let commentButtonDidTapped = PublishRelay<String>()
    public let viewModel: BookDetailViewModel
    private let descriptionView = DescriptionView()
    private let reviewStackView = ReviewStackView()
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
        
        viewWillAppear.accept(())
    }
    
    private func bind() {
        let input = BookDetailViewModel.Input(
            viewWillAppear: viewWillAppear.asObservable(), 
            reviewDetailIsRequired: commentButtonDidTapped.asObservable(), 
            navigateToReviewWrite: reviewWriteButton.rx.tap.asSignal()
        )
        let output = viewModel.transform(input: input)
        output.bookDetail.asObservable()
            .subscribe(onNext: {[weak self] items in
                self?.bookView.configure(with: items)
                self?.descriptionView.configure(with: items.description)
            })
            .disposed(by: disposeBag)

        output.reviewList.asObservable()
            .bind {
                self.reviewStackView.setReview($0)
                self.reviewStackView.genreStackViewCell.delegate = self
            }
            .disposed(by: disposeBag)
        

    }
    private func addView() {
        [
            scrollView,
            reviewWriteButton
        ].forEach { view.addSubview($0) }
        scrollView.addSubview(backStackView)
        [
            bookView,
            descriptionView,
            reviewStackView
        ].forEach { backStackView.addArrangedSubview($0) }
    }
    private func setLayout() {
        scrollView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(reviewWriteButton.snp.top)
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalToSuperview()
        }
        
        backStackView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalToSuperview()
            $0.bottom.equalTo(reviewStackView.snp.bottom)
        }

        reviewWriteButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
    }
    
}

extension BookDetailViewController: BookReviewStackViewCellDelegate {
    func commentButtonDidTapped(id: String) {
        commentButtonDidTapped.accept(id)
    }
    
    
}
