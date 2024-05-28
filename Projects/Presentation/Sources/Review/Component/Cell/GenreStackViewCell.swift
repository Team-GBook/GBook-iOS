import UIKit
import Core
import SnapKit
import DesignSystem
import Then

class GenreStackViewCell: BaseView<Genre> {
    public var genre: Genre
    public var isChecked: Bool = false {
        didSet {
            checkIamgeView.image = isChecked
            ? DesignSystemAsset.Assets.selected.image
            : DesignSystemAsset.Assets.notSelected.image
        }
    }
    private let backStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = .init(top: 12, left: 24, bottom: 12, right: 24)
    }
    private let checkIamgeView = UIImageView().then {
        $0.image = DesignSystemAsset.Assets.notSelected.image
    }
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .medium)
    }

    init(genre: Genre) {
        self.genre = genre
        super.init(frame: .zero)
        titleLabel.text = genre.rawValue
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        self.addSubview(backStackView)
        [
            checkIamgeView,
            titleLabel
        ].forEach(backStackView.addArrangedSubview(_:))

        backStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        checkIamgeView.snp.makeConstraints {
            $0.height.width.equalTo(28)
        }
    }
}
