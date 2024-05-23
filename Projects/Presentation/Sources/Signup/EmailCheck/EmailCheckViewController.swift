import UIKit
import SnapKit
import Then
import DesignSystem

public class EmailCheckViewController: UIViewController {
    
    public let viewModel: EmailCheckViewModel
    public var email: String = ""
    private var textFields: [UITextField] = []

    private let titleLabel = UILabel().then {
        $0.text = "이메일 인증"
        $0.font = .systemFont(ofSize: 32, weight: .bold)
    }
    private let textFieldStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 12
    }
    private let completeButton = GBButton(type: .system).then {
        $0.setTitle("확인", for: .normal)
    }
    public init(viewModel: EmailCheckViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setTextField()
        addView()
        setLayout()
        bind()
    }
    private func bind() {
        let input = EmailCheckViewModel.Input(
            firstCode: textFields[0].rx.text.orEmpty.asObservable(),
            secondCode: textFields[1].rx.text.orEmpty.asObservable(),
            thirdCode: textFields[2].rx.text.orEmpty.asObservable(),
            fourthCode: textFields[3].rx.text.orEmpty.asObservable(),
            email: email,
            completeButtonDidTapped: completeButton.rx.tap.asObservable()
        )
        let _ = viewModel.transform(input: input)
    }
    private func addView() {
        [
            titleLabel,
            textFieldStackView,
            completeButton
        ].forEach { view.addSubview($0) }
    }
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(2)
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(58)
        }
        textFieldStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(18)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(80)
        }
        completeButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
    }
    private func setTextField() {
        for _ in 0..<4 {
            let textField = UITextField()
            textField.layer.cornerRadius = 8
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor.primary?.cgColor
            textField.font = .systemFont(ofSize: 32, weight: .semibold)
            textField.delegate = self
            textField.textAlignment = .center
            textField.keyboardType = .numberPad
            textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
            textFields.append(textField)
            textFieldStackView.addArrangedSubview(textField)
        }
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, text.count >= 1 {
            moveToNextTextField(from: textField)
        }
    }
    func moveToNextTextField(from textField: UITextField) {
        guard let index = textFields.firstIndex(of: textField), textFields.count > index + 1 else { return }
        textFields[index + 1].becomeFirstResponder()
    }
}

extension EmailCheckViewController: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 1
    }
}
