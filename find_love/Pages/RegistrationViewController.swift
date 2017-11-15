import UIKit

class RegistrationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupNavigationBar()
    }
    
    private let _userNameTextField: UITextField = {
        let textField = UITextField()
        textField.defaultInitilization(hint: "Ваше имя")
        textField.useUnderline()
        
        return textField
    }()
    
    private let _userPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.defaultInitilization(hint: "Придумайте пароль")
        textField.useUnderline()
        textField.isSecureTextEntry = true
        
        return textField
    }()
    
    private let _sexLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.text = "УКАЖИТЕ СВОЙ ПОЛ:"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let _maleButton: UIButton = {
        let button = UIButton()
        button.filledCornerInitilization(color: UIColor.darkGray, title: "♂M")
        
        return button
    }()
    
    private let _femaleButton: UIButton = {
        let button = UIButton()
        button.filledCornerInitilization(color: UIColor.darkGray, title: "♀Ж")
        
        return button
    }()
    
    private let _registrationButton: UIButton = {
        let button = UIButton()
        button.filledCornerInitilization(color: UIColor.darkGray,
                                         title: "Зарегистрироваться")
        
        return button
    }()
    
    private let _rememberPassLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.text = "Запомните пароль!"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let _cantRememberPassLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.text = "Его невозможно восстановить в целях безопасности!"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 11)
        
        return label
    }()
    
    private func setupViews() {
        view.addSubview(_userNameTextField)
        view.addSubview(_userPasswordTextField)
        view.addSubview(_sexLabel)
        view.addSubview(_maleButton)
        view.addSubview(_femaleButton)
        view.addSubview(_registrationButton)
        view.addSubview(_rememberPassLabel)
        view.addSubview(_cantRememberPassLabel)
        
        let leftOffset: CGFloat = 40
        let rightOffset: CGFloat = -40
        
        _userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: leftOffset).isActive = true
        _userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: rightOffset).isActive = true
        _userNameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        
        _userPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftOffset).isActive = true
        _userPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: rightOffset).isActive = true
        _userPasswordTextField.topAnchor.constraint(equalTo: _userNameTextField.bottomAnchor, constant: 35).isActive = true
        
        _sexLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        _sexLabel.topAnchor.constraint(equalTo: _userPasswordTextField.bottomAnchor, constant: 30).isActive = true
        
        _maleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftOffset).isActive = true
        _maleButton.topAnchor.constraint(equalTo: _sexLabel.bottomAnchor, constant: 15).isActive = true
        _maleButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.35).isActive = true
        
        _femaleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: rightOffset).isActive = true
        _femaleButton.topAnchor.constraint(equalTo: _sexLabel.bottomAnchor, constant: 15).isActive = true
        _femaleButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.35).isActive = true
        
        _registrationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftOffset).isActive = true
        _registrationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: rightOffset).isActive = true
        _registrationButton.topAnchor.constraint(equalTo: _femaleButton.bottomAnchor, constant: 25).isActive = true
        
        _rememberPassLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftOffset).isActive = true
        _rememberPassLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: rightOffset).isActive = true
        _rememberPassLabel.topAnchor.constraint(equalTo: _registrationButton.bottomAnchor, constant: 10).isActive = true
        
        _cantRememberPassLabel.leadingAnchor.constraint(equalTo: _rememberPassLabel.leadingAnchor).isActive = true
        _cantRememberPassLabel.trailingAnchor.constraint(equalTo: _rememberPassLabel.trailingAnchor).isActive = true
        _cantRememberPassLabel.topAnchor.constraint(equalTo: _rememberPassLabel.bottomAnchor,
                                                    constant: 10).isActive = true
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.black
    }
}
