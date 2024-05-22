import UIKit

public class GBButton: UIButton {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUpButton()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpButton() {
        self.backgroundColor = .primary
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        self.layer.cornerRadius = 12
    }
}
