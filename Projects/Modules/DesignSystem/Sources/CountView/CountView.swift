import UIKit
import SnapKit
import Then

public class CountView: UIView {
    private let backStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
    }
    private let imageView = UIImageView()
    private let countLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.text = "0safas"
    }

    public init(image: UIImage) {
        super.init(frame: .zero)
        imageView.image = image
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setCount(count: Int) {
        countLabel.text = "\(count)"
    }

    public override func layoutSubviews() {
        self.addSubview(backStackView)
        [
            imageView,
            countLabel
        ].forEach(self.backStackView.addArrangedSubview(_:))
        backStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        imageView.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.width.equalTo(22)
        }
        countLabel.snp.makeConstraints {
            $0.height.equalTo(24)
        }
    }
}
