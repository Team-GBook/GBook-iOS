import UIKit

open class BaseView<T>: UIView {

    var item: T?
    public override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        addView()
        setLayout()
    }
    open func addView() { }
    open func setLayout() { }
    open func configure(with item: T) {
        self.item = item
    }
}
