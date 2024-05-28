import UIKit
import SnapKit
import Then
import DesignSystem
import RxSwift
import RxCocoa
public class ProfileViewController: UIViewController {

    public let viewModel: ProfileViewModel
    private let disposeBag = DisposeBag()
    private let viewWillAppear = PublishRelay<Void>()

    private let profileImageView = UIImageView().then {
        $0.layer.cornerRadius = 24
        $0.backgroundColor = .primary50
        $0.clipsToBounds = true
    }
    private let userNameLabel = UILabel().then {
        $0.text = "주게"
        $0.font = .systemFont(ofSize: 16)
    }
    private let profileEditButton = UIButton(type: .system).then {
        $0.setTitle("프로필 수정", for: .normal)
        $0.setTitleColor(.primary50, for: .normal)
    }
    private let bookLikeButton = UIButton(type: .system).then {
        $0.setTitle("좋아요 누른 책 리스트 보기", for: .normal)
        $0.setTitleColor(.onBackground, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.primary50?.cgColor
        $0.layer.cornerRadius = 8
    }
    private let bookReviewButton = UIButton(type: .system).then {
        $0.setTitle("독후감 리스트 보기", for: .normal)
        $0.setTitleColor(.onBackground, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.primary50?.cgColor
        $0.layer.cornerRadius = 8
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
    public init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func bind() {
        let input = ProfileViewModel.Input(
            viewWillAppear: viewWillAppear.asObservable(),
            profileEditButtonDidTapped: profileEditButton.rx.tap.asObservable()
        )
        let output = viewModel.transform(input: input)
        
        output.userProfile.asObservable()
            .subscribe(onNext: { [weak self] item in
                self?.profileImageView.kf.setImage(with: URL(string: item.profileImage))
                self?.userNameLabel.text = item.nickName
            })
            .disposed(by: disposeBag)
    }
    private func addView() {
        [
            profileImageView,
            userNameLabel,
            profileEditButton,
            bookLikeButton,
            bookReviewButton
        ].forEach { view.addSubview($0) }
    }
    private func setLayout() {
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(12)
            $0.leading.equalToSuperview().inset(24)
            $0.width.height.equalTo(48)
        }
        userNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(8)
            $0.height.equalTo(24)
        }
        profileEditButton.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView)
            $0.trailing.equalToSuperview().inset(28)
            $0.height.equalTo(24)
        }
        bookLikeButton.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(36)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(44)
        }
        bookReviewButton.snp.makeConstraints {
            $0.top.equalTo(bookLikeButton.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(44)
        }
    }

}
