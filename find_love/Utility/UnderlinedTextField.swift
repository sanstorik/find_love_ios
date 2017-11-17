import UIKit

class UnderlinedTextField: UITextField {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: frame.size.height - width,
                              width:  frame.size.width, height: frame.size.height)
        
        border.borderWidth = width
        layer.addSublayer(border)
        layer.masksToBounds = true
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 0, dy: 7)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 0, dy: 7)
    }
}
