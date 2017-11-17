import UIKit

class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        setupViews()
        setupNavigationBar()
    }
    
    private var _buttonSelectors = [Selector]()
    private var _buttonTitles = [String]()
    
    private func setupViews() {
        _buttonSelectors += [#selector(changeForm), #selector(recoverPurchases),
                             #selector(termsOfUse), #selector(deleteProfile),
                             #selector(muteSound), #selector(respondUs)]
        _buttonTitles += ["Изменить анкету", "Восстановить покупки", "Условия использования",
                          "Удалить профиль", "Отключить звук", "Напишите нам"]
        
        var currentTopView = self.view!
        
        for i in 0..<_buttonSelectors.count {
            currentTopView = createButton(title: _buttonTitles[i],
                                          action: _buttonSelectors[i], below: currentTopView)
        }
        
        currentTopView.backgroundColor = UIColor.red
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.topItem?.title = " "
        
        navigationItem.title = "Настройки"
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.white,
             NSAttributedStringKey.font: UIFont.systemFont(ofSize: 28)]
        
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    private func createButton(title: String, action: Selector, below view: UIView) -> UIView {
        let button = UIButton()
        button.filledCornerInitilization(color: UIColor(red: 91, green: 93, blue: 84), title: title, cornerRadius: 30)
        button.addTarget(self, action: action, for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight(0.15))
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
    
    @objc private func termsOfUse() {
        
    }
    
    @objc private func deleteProfile() {
        
    }
    
    @objc private func muteSound() {
        
    }
    
    @objc private func respondUs() {
        
    }
}
