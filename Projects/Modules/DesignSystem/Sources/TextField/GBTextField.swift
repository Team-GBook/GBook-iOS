import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

public class GBTextField: UITextField {

    private var disposeBag = DisposeBag()
    public var isSecurity: Bool = false {
        didSet {
            textHideButton.isHidden = !isSecurity
            self.isSecureTextEntry = true
            self.addPadding()
        }
    }
    private let textHideButton = UIButton().then {
        $0.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        $0.tintColor = .onBackground
        $0.contentMode = .scaleAspectFit
        $0.isHidden = true
    }
    
    public init() {
        super.init(frame: .zero)
        setUpTextField()
        setPlaceholderTextColor()
        defaultPadding()
        textHideButton.rx.tap.subscribe(onNext:{ [weak self] in
            self?.isSecureTextEntry.toggle()
            let imageName = (self?.isSecureTextEntry ?? false) ? "eye.fill" : "eye.slash.fill"
            self?.textHideButton.setImage(UIImage(systemName:imageName), for:.normal)
        }).disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(textHideButton)
        textHideButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
            $0.width.height.equalTo(24)
        }
    }
    private func setUpTextField() {
        self.layer.cornerRadius = 12
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.onBackground?.cgColor
        self.autocorrectionType = .no
        self.spellCheckingType = .no
    }
    private func setPlaceholderTextColor() {
        
        guard let string = self.placeholder else {
            return
        }
        attributedPlaceholder = NSAttributedString(string: string, attributes: [
            .foregroundColor: UIColor.onBackground!,
            .font: UIFont.systemFont(
                ofSize: 16,
                weight: .medium
            )
        ]
        )
    }
}
