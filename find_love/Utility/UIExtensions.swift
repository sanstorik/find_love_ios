import UIKit

extension UITextField {
    func defaultInitilization(hint: String) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = UIColor.white
        let placeholder = NSAttributedString(string: hint,
                                             attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        
        self.attributedPlaceholder = placeholder
        self.textAlignment = .center
    }
}

extension UIButton {
    func filledCornerInitilization(color: UIColor, title: String, cornerRadius: CGFloat = 20) {
        backgroundColor = color
        setTitle(title, for: .normal)
        setTitleColor(UIColor.white, for: .normal)
        layer.borderColor = color.cgColor
        layer.cornerRadius = cornerRadius
        layer.borderWidth = 1
        
        translatesAutoresizingMaskIntoConstraints = false
    }
}
