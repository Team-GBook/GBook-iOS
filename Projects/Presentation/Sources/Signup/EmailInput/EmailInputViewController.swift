import UIKit
import SnapKit
import Then
import DesignSystem

public class EmailInputViewController: UIViewController {
    
    public let viewModel: EmailInputViewModel
    
    private let titleLabel = UILabel().then {
        $0.text = "이메일 인증"
        $0.font = .systemFont(ofSize: 32, weight: .bold)
    }
    private let emailTextField = GBTextField().then {
        $0.placeholder = "이메일"
    }
    private let certificationButton = GBButton(type: .system).then {
        $0.setTitle("인증번호 전송", for: .normal)
    }
    
    public init(viewModel: EmailInputViewModel) {
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
        let input = EmailInputViewModel.Input(
            emailText: emailTextField.rx.text.orEmpty.asObservable(),
            nextButtonDidTapped: certificationButton.rx.tap.asObservable()
        )
        let _ = viewModel.transform(input: input)
    }
    private func addView() {
        [
            titleLabel,
            emailTextField,
            certificationButton
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
        certificationButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
    }
}
