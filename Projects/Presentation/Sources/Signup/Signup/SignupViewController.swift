import UIKit
import SnapKit
import Then
import DesignSystem

public class SignupViewController: UIViewController {

    public let viewModel: SignupViewModel
    public var email: String = ""

    private let titleLabel = UILabel().then {
        $0.text = "프로필 설정"
        $0.font = .systemFont(ofSize: 32, weight: .bold)
    }
    private let nameTextField = GBTextField().then {
        $0.placeholder = "이름(닉네임)"
    }
    private let passwordTextField = GBTextField().then {
        $0.placeholder = "비밀번호"
        $0.isSecurity = true
    }
    private let passwordCheckTextField = GBTextField().then {
        $0.placeholder = "비밀번호 확인"
        $0.isSecurity = true
    }
    private let signupButton = GBButton(type: .system).then {
        $0.setTitle("회원가입", for: .normal)
    }
    public init(viewModel: SignupViewModel) {
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
        let input = SignupViewModel.Input(
            nameText: nameTextField.rx.text.orEmpty.asObservable(),
            passwordText: passwordTextField.rx.text.orEmpty.asObservable(),
            passwordCheckText: passwordCheckTextField.rx.text.orEmpty.asObservable(),
            email: email,
            signupButtonDidTapped: signupButton.rx.tap.asObservable()
        )
        let _ = viewModel.transform(input: input)
    }
    private func addView() {
        [
            titleLabel,
            nameTextField,
            passwordTextField,
            passwordCheckTextField,
            signupButton
        ].forEach { view.addSubview($0) }
    }
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(2)
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(58)
        }
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
        passwordCheckTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
        signupButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
    }
}
