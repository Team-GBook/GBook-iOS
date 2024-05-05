import UIKit

extension UITextField {
    func addPadding() {
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: self.frame.height))
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: self.frame.height))
        self.leftView = leftPaddingView
        self.leftViewMode = ViewMode.always
        self.rightView = rightPaddingView
        self.rightViewMode = ViewMode.always
    }
}
