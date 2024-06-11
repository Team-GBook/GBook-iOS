import UIKit
import SnapKit
import Then
import DesignSystem
import RxSwift
import RxCocoa

public class BookReviewDetailViewController: UIViewController {
    
    private var isMine: Bool = false
    private var isbn: String = ""
    private let viewWillAppear = PublishRelay<Void>()
    private let editIsRequired = PublishRelay<String>()
    private let deleteIsRequired = PublishRelay<String>()
    private let popToRootIsRequired = PublishRelay<Void>()
    private let disposeBag = DisposeBag()
    public let viewModel: BookReviewDetailViewModel
    private let titleLabel = UILabel().then {
        $0.text = "1ijjnjk1ij"
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        
    }
    private let nameLabel = UILabel().then {
        $0.text = "1ijjnjk"
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.textColor = .onSurface
    }
    private let dateLabel = UILabel().then {
        $0.text = "1ijjnjk"
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.textColor = .onSurface
    }
    private lazy var reviewStackView = UIStackView(arrangedSubviews: [
        titleLabel,
        nameLabel,
        dateLabel
    ]).then {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 4
    }
    private let editButton = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "edit"), for: .normal)
        $0.setImageTintColor(.black)
        $0.showsMenuAsPrimaryAction = true
    }
    private let reviewDescriptionView = ReviewDesCriptionView()
    
    private let commentLabel = UILabel().then {
        $0.text = "댓글"
        $0.font = .systemFont(ofSize: 20, weight: .medium)
    }
    private let commentButton = UIButton(type: .system).then {
        $0.setTitle("댓글로 이동", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 12
    }
    public init(viewModel: BookReviewDetailViewModel) {
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
        setUpControl()
    }
    private func bind() {
        let input = BookReviewDetailViewModel.Input(
            viewWillAppear: viewWillAppear.asObservable(),
            editIsRequired: editIsRequired.asObservable(),
            deleteIsRequired: deleteIsRequired.asObservable(),
            reviewCommentIsRequired: commentButton.rx.tap.asObservable(),
            popToRootView: popToRootIsRequired.asObservable()
        )
        let output = viewModel.transform(input: input)
        output.reviewDetiail.asObservable()
            .subscribe(onNext: { [weak self] item in
                self?.titleLabel.text = item.title
                self?.isbn = item.isbn
                self?.nameLabel.text = item.user
                self?.dateLabel.text = item.createdAt
                self?.reviewDescriptionView.configure(with: item)
                if item.isMine {
                    self?.editButton.isHidden = false
                }else {
                    self?.editButton.isHidden = true
                }
            })
            .disposed(by: disposeBag)
        
    }
    private func setUpControl()  {
        
        let deleteAlertController = UIAlertController(
            title: nil,
            message: "독후감을 삭제하시겠습니까?",
            preferredStyle: .alert
        )
        let checkAction = UIAlertAction(
            title: "확인",
            style: .destructive,
            handler: { [weak self] _ in
                self?.deleteIsRequired.accept(self?.isbn ?? "")
                self?.popToRootIsRequired.accept(())
            }
        )
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        [checkAction, cancelAction].forEach { deleteAlertController.addAction($0) }
        
        let deleteAction = UIAction(
            title: "삭제하기",
            image: UIImage(systemName: "trash"),
            attributes: .destructive,
            handler: { [weak self] _ in
                self?.present(deleteAlertController, animated: true, completion: nil)
            }
        )
        let editAction = UIAction(
            title: "수정하기",
            image: UIImage(systemName: "pencil"),
            handler: { _ in
                self.editIsRequired.accept(self.isbn)
            }
        )
        let menu = UIMenu(children: [deleteAction, editAction])
        editButton.menu = menu
        
    }
    private func addView() {
        [
            reviewStackView,
            editButton,
            reviewDescriptionView,
            commentLabel,
            commentButton
        ].forEach { view.addSubview($0) }
    }
    private func setLayout() {
        reviewStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(32)
        }
        editButton.snp.makeConstraints {
            //            $0.centerY.equalTo(reviewStackView)
            $0.top.equalTo(reviewStackView.snp.top)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(16)
        }
        reviewDescriptionView.snp.makeConstraints {
            $0.top.equalTo(reviewStackView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        commentLabel.snp.makeConstraints {
            $0.bottom.equalTo(commentButton.snp.top).inset(-18)
            $0.leading.equalToSuperview().inset(24)
            $0.height.equalTo(24)
        }
        commentButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(48)
        }
    }
}
