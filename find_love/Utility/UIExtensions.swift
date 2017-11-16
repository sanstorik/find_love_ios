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

import UIKit

extension UIView {
    private static let loaderTag = 9999
    
    private var loaderView: UIView? {
        return viewWithTag(UIView.loaderTag)
    }
    
    var loaderViewIsPresented: Bool {
        return loaderView != nil
    }
    
    func showLoader() {
        loaderView?.removeFromSuperview()
        
        let container = UIView()
        container.tag = UIView.loaderTag
        container.backgroundColor = UIColor.black
        isUserInteractionEnabled = false
        container.translatesAutoresizingMaskIntoConstraints = false
        addSubview(container)
        
        let indicatorConrainer = UIView()
        indicatorConrainer.backgroundColor = UIColor.black
        indicatorConrainer.alpha = 0.5
        indicatorConrainer.layer.cornerRadius = 5
        indicatorConrainer.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(indicatorConrainer)
        
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicatorConrainer.addSubview(indicator)
        
        let views: [String: Any] = ["container": container,
                                    "indicator": indicator]
        var cnts: [NSLayoutConstraint] = []
        
        cnts += NSLayoutConstraint.constraints(withVisualFormat: "H:|[container]|", options: [], metrics: nil, views: views)
        cnts += NSLayoutConstraint.constraints(withVisualFormat: "V:|[container]|", options: [], metrics: nil, views: views)
        cnts += [NSLayoutConstraint(item: indicatorConrainer, attribute: .width, relatedBy: .equal, toItem: container, attribute: .width, multiplier: 0.2, constant: 0)]
        cnts += [NSLayoutConstraint(item: indicatorConrainer, attribute: .height, relatedBy: .equal, toItem: indicatorConrainer, attribute: .width, multiplier: 1, constant: 0)]
        cnts += [NSLayoutConstraint(item: indicatorConrainer, attribute: .centerX, relatedBy: .equal, toItem: container, attribute: .centerX, multiplier: 1, constant: 0)]
        cnts += [NSLayoutConstraint(item: indicatorConrainer, attribute: .centerY, relatedBy: .equal, toItem: container, attribute: .centerY, multiplier: 1, constant: 0)]
        cnts += NSLayoutConstraint.constraints(withVisualFormat: "H:|[indicator]|", options: [], metrics: nil, views: views)
        cnts += NSLayoutConstraint.constraints(withVisualFormat: "V:|[indicator]|", options: [], metrics: nil, views: views)
        
        NSLayoutConstraint.activate(cnts)
        setNeedsLayout()
        bringSubview(toFront: container)
    }
    
    func removeLoader() {
        isUserInteractionEnabled = true
        UIView.animate(withDuration: 0.3, animations: {
            self.loaderView?.alpha = 0
        }) { _ in
            self.loaderView?.removeFromSuperview()
        }
    }
    
    func removeLoaderImmediately() {
        isUserInteractionEnabled = true
        loaderView?.removeFromSuperview()
        loaderView?.alpha = 0
    }
}
