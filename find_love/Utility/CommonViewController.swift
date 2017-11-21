import UIKit


protocol NavigationBar {
    func setupNavigationBar(title: String?, withImage imageView: UIView?)
}

extension NavigationBar where Self: UIViewController {
    func setupNavigationBar(title: String? = nil, withImage imageView: UIView? = nil) {
        navigationBar(title: title ?? "")
        
        navigationItem.titleView = imageView
    }
    
    func animateTitleColor(_ color: UIColor, duration: Double = 1) {
        UIView.animate(withDuration: duration) { [unowned self] () -> Void in
            self.navigationController?.navigationBar.titleTextAttributes =
                [NSAttributedStringKey.foregroundColor: color,
                 NSAttributedStringKey.font: UIFont.systemFont(ofSize: 28)]
        }
    }
    
    fileprivate func navigationBar(title: String) {
        navigationItem.title = title
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.white,
             NSAttributedStringKey.font: UIFont.systemFont(ofSize: 28)]
        
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.tintColor = UIColor.white
        
        self.navigationController?.navigationBar.topItem?.backBarButtonItem =
            UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}


typealias KeyboardEvent = (_ :NSNotification) -> Void
/** Keyboard observer for pushing view up
 */
extension CommonViewController {
    final func registerKeyboardObservers(keyboardShowEvent: KeyboardEvent? = nil,
                                         keyboardHideEvent: KeyboardEvent? = nil) {
        _onKeyboardHideEvent = keyboardHideEvent
        _onKeyboardShownEvent = keyboardShowEvent
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    final func registerKeyboardObserversWith(offset: CGFloat, keyboardShowEvent: KeyboardEvent? = nil,
                                                   keyboardHideEvent: KeyboardEvent? = nil) {
        _onKeyboardHideEvent = keyboardHideEvent
        _onKeyboardShownEvent = keyboardShowEvent
        _keyboardOffset = offset
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWithSizeShow),
                                               name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWithSizeHide),
                                               name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    final func unregisterKeyboardObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @objc fileprivate func keyboardWillShow(notification: NSNotification) {
        let keyboardSize = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let offset = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size
        
        guard let size = keyboardSize, let newOffset = offset else {
            return
        }
        
        if size.height == newOffset.height && !_isKeyboardShown {
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                self.view.frame.origin.y -= size.height
            })
        } else {
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                self.view.frame.origin.y += size.height - newOffset.height
            })
        }
        
        _isKeyboardShown = true
        _onKeyboardShownEvent?(notification)
    }
    
    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = calculateKeyboardHeight(notification: notification) {
            view.frame.origin.y += keyboardSize.height
            _isKeyboardShown = false
        }
        
        _onKeyboardHideEvent?(notification)
    }
    
    @objc fileprivate func keyboardWithSizeShow(_ notification: NSNotification) {
        if let _ = calculateKeyboardHeight(notification: notification), !_isKeyboardShown {
            UIView.animate(withDuration: 0.1, animations: { [unowned self]() -> Void in
                self.view.frame.origin.y -= self._keyboardOffset
            })
            _isKeyboardShown = true
        }
        
        _onKeyboardShownEvent?(notification)
    }
    
    @objc fileprivate func keyboardWithSizeHide( _ notification: NSNotification) {
        if let _ = calculateKeyboardHeight(notification: notification), _isKeyboardShown {
            self.view.frame.origin.y += self._keyboardOffset
            _isKeyboardShown = false
        }
        
        _onKeyboardHideEvent?(notification)
    }
    
    fileprivate func calculateKeyboardHeight(notification: NSNotification) -> CGRect? {
        return (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
    }
}

class CommonViewController: UIViewController, NavigationBar {
    fileprivate var _isKeyboardShown = false
    fileprivate var _onKeyboardShownEvent: KeyboardEvent?
    fileprivate var _onKeyboardHideEvent: KeyboardEvent?
    fileprivate var _keyboardOffset: CGFloat = 50
}
