import UIKit
import SnapKit
import Then
import DesignSystem
import RxSwift

public class OnboardingViewController: UIViewController {

    public let viewModel: OnboardingViewModel

    private let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "logo")
    }
    private let loginButton = GBButton(type: .system).then {
        $0.setTitle("로그인", for: .normal)
    }
    private let signUpButton = UIButton(type: .system).then {
        $0.setTitle("아이디가 아직 없으신가요?", for: .normal)
        $0.setTitleColor(.primary, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
    }

    public init(viewModel: OnboardingViewModel) {
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
    private func bind() {
        let input = OnboardingViewModel.Input(
            loginButtonDidTapped: loginButton.rx.tap.asObservable(),
            signupButtonDidTapped: signUpButton.rx.tap.asObservable()
        )
        let _ = viewModel.transform(input: input)
    }
    private func addView() {
        [
            logoImageView,
            loginButton,
            signUpButton
        ].forEach { view.addSubview($0) }
    }
    private func setLayout() {
        logoImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        loginButton.snp.makeConstraints {
            $0.bottom.equalTo(signUpButton.snp.top).offset(-12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
        signUpButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(24)
        }
    }
}
