import UIKit
import RxCocoa
import RxSwift
import SnapKit
import Then

public class ReplyViewController: UIViewController {
    private let viewWillAppear = PublishRelay<Void>()
    private let disposeBag = DisposeBag()
    public let viewModel: ReplyViewModel
    private let commentView = CommentView()
    private let replyTableView = UITableView().then {
        $0.register(ReplyTableViewCell.self, forCellReuseIdentifier: ReplyTableViewCell.identifier)
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

    public init(viewModel: ReplyViewModel) {
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
        commentView.configure(
            userName: viewModel.userName,
            content: viewModel.content,
            replyCount: viewModel.replyCount
        )
    }

    private func bind() {
        let input = ReplyViewModel.Input(
            viewWillAppear: viewWillAppear.asObservable(),
            commentText: commentTextField.rx.text.orEmpty.asObservable(),
            sendButtonDidTapped: sendButton.rx.tap.asObservable()
        )
        let output = viewModel.transform(input: input)
        output.replyList.asObservable()
            .bind(to: replyTableView.rx.items(
                cellIdentifier: ReplyTableViewCell.identifier,
                cellType: ReplyTableViewCell.self)
            ) { row, item, cell in
                cell.configure(with: item)
            }
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
            commentView,
            replyTableView,
            sendStackView
        ].forEach { view.addSubview($0) }
    }
    private func setLayout() {
        commentView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(12)
            $0.leading.trailing.equalToSuperview()
        }
        replyTableView.snp.makeConstraints {
            $0.top.equalTo(commentView.snp.bottom)
            $0.leading.equalToSuperview().inset(21)
            $0.trailing.equalToSuperview()
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
