import UIKit
import SnapKit
import Then
import Core

class DescriptionView: BaseView<String> {
    private let backStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = .init(top: 8, left: 24, bottom: 0, right: 24)
    }
    private let descriptionTitleLabel = UILabel().then {
        $0.text = "줄거리"
        $0.font = .systemFont(ofSize: 20, weight: .medium)
    }
    private let descriptionLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.numberOfLines = 0
    }
    override func configure(with item: String) {
        self.descriptionLabel.text = item
    }

    override func addView() {
        self.addSubview(backStackView)
        [
            descriptionTitleLabel,
            descriptionLabel
        ].forEach(backStackView.addArrangedSubview(_:))
    }
    override func setLayout() {
        backStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
