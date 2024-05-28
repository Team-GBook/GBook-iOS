import UIKit
import SnapKit

public class BottomLineView: UIView {

    public override init(frame: CGRect) {
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func initialize() {
        self.backgroundColor = .netrual40
        self.snp.makeConstraints {
            $0.height.equalTo(1)
        }
    }
}
