import UIKit
import Domain
import SnapKit
import Then
import DesignSystem
import RxSwift
import RxCocoa

public class ReviewCommentViewController: UIViewController {
    
    private let viewWillAppear = PublishRelay<Void>()
    private let disposeBag = DisposeBag()
    public let viewModel: ReviewCommentViewModel
    private let commentTableView = UITableView().then {
        $0.register(ReviewCommentCell.self, forCellReuseIdentifier: ReviewCommentCell.identifier)
        $0.rowHeight = UITableView.automaticDimension
        $0.separatorStyle = .none
    }
    private let commentTextField = UITextField().then {
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.onBackground?.cgColor
        $0.defaultPadding()
    }
    private let sendButton = UIButton(type: .system).then {
        $0.setImage(UIImage(systemName: "paperplane"), for: .normal)
        $0.setImageTintColor(.white)
        $0.layer.cornerRadius = 12
        $0.backgroundColor = .primary50
    }
    private lazy var sendStackView = UIStackView(arrangedSubviews: [
        commentTextField,
        sendButton
    ]).then {
        $0.spacing = 10
    }
    public init(viewModel: ReviewCommentViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewWillAppear(_ animated: Bool) {
        viewWillAppear.accept(())
    }
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addView()
        setLayout()
        bind()
        
    }
    private func bind() {
        let input = ReviewCommentViewModel.Input(
            viewWillAppear: viewWillAppear.asObservable(),
            commentTableViewCellDidTap: commentTableView.rx.modelSelected(CommentElement.self).asObservable(),
            commentText: commentTextField.rx.text.orEmpty.asObservable(),
            sendButtonDidTapped: sendButton.rx.tap.asObservable()
        )
        let output = viewModel.transform(input: input)
        output.commentList.asObservable()
            .bind(to: commentTableView.rx.items(
                cellIdentifier: ReviewCommentCell.identifier,
                cellType: ReviewCommentCell.self)
            ) { row, item, cell in
                cell.configure(with: item)            }
            .disposed(by: disposeBag)
        sendButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.commentTextField.text = ""
                self?.viewWillAppear.accept(())
            })
            .disposed(by: disposeBag)
    }
    private func addView() {
        [
            commentTableView,
            sendStackView
        ].forEach { view.addSubview($0) }
    }
    private func setLayout() {
        commentTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(12)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(sendStackView.snp.top)
        }
        sendButton.snp.makeConstraints {
            $0.width.equalTo(48)
        }
        sendStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(12)
            $0.height.equalTo(48)
        }
    }
}
