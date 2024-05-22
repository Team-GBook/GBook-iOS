import UIKit
import Then
import SnapKit
import DesignSystem
import RxSwift

public class LoginViewController: UIViewController {

    public let viewModel: LoginViewModel
    private let titleLabel = UILabel().then {
        $0.text = "로그인"
        $0.font = .systemFont(ofSize: 32, weight: .bold)
    }
    private let emailTextField = GBTextField().then {
        $0.placeholder = "이메일"
    }
    private let passwordTextField = GBTextField().then {
        $0.placeholder = "비밀번호"
        $0.isSecurity = true
    }
    private let loginButton = GBButton(type: .system).then {
        $0.setTitle("로그인", for: .normal)
    }

    public init(viewModel: LoginViewModel) {
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
        let input = LoginViewModel.Input(
            emailText: emailTextField.rx.text.orEmpty.asObservable(),
            passwordText: passwordTextField.rx.text.orEmpty.asObservable(),
            loginButtonDidTapped: loginButton.rx.tap.asObservable()
        )
        let _ = viewModel.transform(input: input)
    }
    private func addView() {
        [
            titleLabel,
            emailTextField,
            passwordTextField,
            loginButton
        ].forEach { view.addSubview($0) }
    }
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(2)
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
        loginButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-12)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
    }
}
