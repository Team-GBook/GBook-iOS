import UIKit

open class BaseTableViewCell<T>: UITableViewCell {

    var item: T?
    public override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )
        commonInit()
    }
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        addView()
        setLayout()
    }
    open override func prepareForReuse() {
        super.prepareForReuse()
    }
    open func addView() { }
    open func setLayout() { }
    open func configure(with item: T) {
        self.item = item
    }
}
