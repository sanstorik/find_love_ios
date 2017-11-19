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

extension UIImageView {
    func startScaleAnimation(scaleX: CGFloat, scaleY: CGFloat) {
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.repeat, .autoreverse],
                       animations: {
                  self.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        })
    }
    
    func stopAnimations() {
        layer.removeAllAnimations()
    }
}
