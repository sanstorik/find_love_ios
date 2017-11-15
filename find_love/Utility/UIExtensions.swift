import UIKit


class InsetTextField: UITextField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 0, dy: 5)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 0, dy: 5)
    }
}

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
    func filledCornerInitilization(color: UIColor, title: String) {
        backgroundColor = color
        setTitle(title, for: .normal)
        setTitleColor(UIColor.white, for: .normal)
        layer.borderColor = color.cgColor
        layer.cornerRadius = 20
        layer.borderWidth = 1
        
        translatesAutoresizingMaskIntoConstraints = false
    }
}
