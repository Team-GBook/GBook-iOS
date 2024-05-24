import UIKit
import DesignSystem
import Core
import SnapKit
import Then

class ReviewInfoView: UIView {
    private var textViewHeight = 0.0
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .medium)
    }
    private let textView = GBTextView()
    
    init(title: String, placeholder: String, textViewHeight: CGFloat = 150) {
        super.init(frame: .zero)
        titleLabel.text = title
        self.textViewHeight = textViewHeight
        self.textView.placeholder = placeholder
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        [
            titleLabel,
            textView
        ].forEach(self.addSubview(_:))

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().inset(24)
            $0.height.equalTo(24)
        }
        textView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(18)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(textViewHeight)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
}
