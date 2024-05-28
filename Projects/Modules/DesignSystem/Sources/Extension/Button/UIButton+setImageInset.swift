import UIKit

public extension UIButton {
    public func setImageInset(intervalSpacing: CGFloat) {
        let halfIntervalSpacing = intervalSpacing / 2
        self.contentEdgeInsets = .init(top: 0, left: CGFloat(halfIntervalSpacing), bottom: 0, right: CGFloat(halfIntervalSpacing))
        self.imageEdgeInsets = .init(top: 0, left: -CGFloat(halfIntervalSpacing), bottom: 0, right: CGFloat(halfIntervalSpacing))
        self.titleEdgeInsets = .init(top: 0, left: CGFloat(halfIntervalSpacing), bottom: 0, right: -CGFloat(halfIntervalSpacing))
    }
}
