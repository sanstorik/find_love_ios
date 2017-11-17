import UIKit


protocol NavigationBar {
    func setupNavigationBar(title: String)
    func setupNavigationBar(imageView: UIView)
}

extension NavigationBar where Self: UIViewController {
    func setupNavigationBar(title: String) {
        navigationBar(title: title)
    }
    
    func setupNavigationBar(imageView: UIView) {
        navigationBar(title: "")
        
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
        
        self.navigationController?.navigationBar.topItem?.backBarButtonItem
            = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

class CommonViewController: UIViewController, NavigationBar {

}
