import UIKit
import SnapKit
import Then

open class GBTextView: UITextView {
    public var placeholder: String?
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .medium)
    }

    public init(
//        title: String? = nil,
        placeholder: String? = nil
    ) {
        super.init(
            frame: .zero,
            textContainer: .none
        )
//        self.titleLabel.text = title
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    open override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(titleLabel)
//        titleLabel.snp.makeConstraints {
//            $0.top.equalToSuperview().inset(-10)
//            $0.leading.equalToSuperview().inset(14)
//            $0.height.equalTo(24)
//        }
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 12
        self.layer.borderColor = UIColor.onBackground?.cgColor
        self.font = .systemFont(ofSize: 16, weight: .medium)
        self.addPadding()
    }
}
