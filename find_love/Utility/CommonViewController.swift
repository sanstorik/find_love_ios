import UIKit


protocol NavigationBar {
    func setupNavigationBar(title: String?, withImage imageView: UIView?)
}

extension NavigationBar where Self: UIViewController {
    func setupNavigationBar(title: String? = nil, withImage imageView: UIView? = nil) {
        navigationBar(title: title ?? "")
        
        navigationItem.titleView = imageView
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


/** Keyboard observer for pushing view up
 */
extension CommonViewController {
    final func registerKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
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
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = calculateKeyboardHeight(notification: notification) {
            view.frame.origin.y += keyboardSize.height
            _isKeyboardShown = false
        }
    }
    
    fileprivate func calculateKeyboardHeight(notification: NSNotification) -> CGRect? {
        return (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
    }
}

class CommonViewController: UIViewController, NavigationBar {
    fileprivate var _isKeyboardShown = false
}
