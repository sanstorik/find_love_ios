import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupNavigationBar()
    }
    
    private var _buttonSelectors = [Selector]()
    private var _buttonTitles = [String]()
    
    private func setupViews() {
        _buttonSelectors += [#selector(changeForm), #selector(recoverPurchases)]
        _buttonTitles += ["Изменить анкету", "Восстановить покупки"]
        
        var currentTopView = self.view!
        
        for i in 0..<_buttonSelectors.count {
            currentTopView = createButton(title: _buttonTitles[i],
                                          action: _buttonSelectors[i], below: currentTopView)
        }
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Настройки"
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.lightGray,
             NSAttributedStringKey.font: UIFont.systemFont(ofSize: 28)]
        
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.black
    }
    
    private func createButton(title: String, action: Selector, below view: UIView) -> UIView {
        let button = UIButton()
        button.filledCornerInitilization(color: UIColor.darkGray, title: title, cornerRadius: 30)
        button.addTarget(self, action: action, for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight(0.2))
        button.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(button)
        
        button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25).isActive = true
        button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25).isActive = true
        
        if view === self.view {
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        } else {
            button.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 20).isActive = true
        }
        
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        return button
    }
    
    @objc private func changeForm() {
        
    }
    
    @objc private func recoverPurchases() {
        
    }
}
