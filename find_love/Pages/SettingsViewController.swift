import UIKit
import MessageUI

class SettingsViewController: CommonViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar(title: "Настройки")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        setupViews()
    }
    
    private var _buttonSelectors = [Selector]()
    private var _buttonTitles = [String]()
    private var _soundButton: UIButton!
    private var _isSoundDisabled = UserDefaults.standard.bool(forKey: "sound")
    
    private func setupViews() {
        _buttonSelectors += [#selector(changeFormOnClick), #selector(recoverPurchasesOnClick),
                             #selector(termsOfUseOnClick), #selector(deleteProfileOnClick),
                             #selector(muteSoundOnClick), #selector(respondUsOnClick)]
        
        let soundButtonTitle = _isSoundDisabled ? "Включить звук" : "Отключить звук"
        _buttonTitles += ["Изменить анкету", "Восстановить покупки", "Условия использования",
                          "Удалить профиль", soundButtonTitle, "Напишите нам"]
        
        var currentTopView = self.view!
        
        for i in 0..<_buttonSelectors.count {
            let button = createButton(title: _buttonTitles[i],
                                          action: _buttonSelectors[i], below: currentTopView)
            currentTopView = button
            
            if i == 4 {
                _soundButton = button as! UIButton
            }
        }
        
        currentTopView.backgroundColor = UIColor.red
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
    
    @objc private func changeFormOnClick() {
        let formChanger = NewFormViewController()
        formChanger.isEditingSession = true
        
        navigationController?.pushViewController(formChanger, animated: true)
    }
    
    @objc private func recoverPurchasesOnClick() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.showLoaderFullScreen()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) { [unowned self] () -> Void in
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            self.view.removeLoader {
                let alert = UIAlertController(title: nil, message: "Активность вашей подписки подтверджена", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Oк", style: .default, handler: nil))
                
                self.present(alert, animated: true)
            }
        }
    }
    
    @objc private func termsOfUseOnClick() {
        navigationController?.pushViewController(TermsOfUseViewController(), animated: true)
    }
    
    @objc private func deleteProfileOnClick() {
        let alert = UIAlertController(title: "Удалить профиль", message: "Вся информация о вашей переписке будет удалена. Продолжить?",
                                      preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { [unowned self] action -> Void in
            self.deleteProfile()
        }))
        
        alert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    @objc private func muteSoundOnClick() {
        _isSoundDisabled = !_isSoundDisabled
        UserDefaults.standard.set(_isSoundDisabled, forKey: "sound")
       _soundButton.setTitle(_isSoundDisabled ? "Включить звук" : "Отключить звук", for: .normal)
    }
    
    @objc private func respondUsOnClick() {
        let mail = MFMailComposeViewController()
        mail.setSubject("Feedback love search")
        mail.setToRecipients(["our staff"])
        mail.delegate = self
        
        if MFMailComposeViewController.canSendMail() {
            present(mail, animated: true, completion: nil)
        } else {
            print("cant send mails")
        }
    }
    
    private func deleteProfile() {
    }
}

extension SettingsViewController: MFMailComposeViewControllerDelegate, UINavigationControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
