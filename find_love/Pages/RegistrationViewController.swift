import UIKit
import UIView_Shake

class UsernameTextFieldDelegate: NSObject, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

class RegistrationViewController: CommonViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        setupViews()
        registerKeyboardObservers()
    }
    
    private let _userNameTextField: UITextField = {
        let textField: UITextField = UnderlinedTextField()
        textField.defaultInitilization(hint: "Ваше имя")
        
        return textField
    }()
    
    private let _userPasswordTextField: UITextField = {
        let textField: UITextField = UnderlinedTextField()
        textField.defaultInitilization(hint: "Придумайте пароль")
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
        label.font = UIFont.systemFont(ofSize: 12)
        
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private var _sex: Sex?
    private let delegate = UsernameTextFieldDelegate()
    
    @objc private func registerOnClick() {
        var areFormsFilled = true
        
        let name = _userNameTextField.text
        if name == nil || name!.isEmpty {
            areFormsFilled = false
            _userNameTextField.shake(3, withDelta: 8, speed: 0.05)
        }
        
        let password = _userPasswordTextField.text
        if password == nil || password!.isEmpty {
            areFormsFilled = false
            _userPasswordTextField.shake(3, withDelta: 8, speed: 0.05)
        }
        
        if _sex == nil {
            areFormsFilled = false
            _maleButton.shake(3, withDelta: 8, speed: 0.05)
            _femaleButton.shake(3, withDelta: 8, speed: 0.05)
        }
        
        if areFormsFilled {
            navigationController?.pushViewController(RulesViewController(), animated: true)
        }
    }
    
    @objc private func maleButtonOnClick() {
        _maleButton.backgroundColor = UIColor.red
        _femaleButton.backgroundColor = UIColor.darkGray
        
        _sex = .male
    }
    
    @objc private func femaleButtonOnClick() {
        _femaleButton.backgroundColor = UIColor.red
        _maleButton.backgroundColor = UIColor.darkGray
        
        _sex = .female
    }
    
    private func setupViews() {
        
        _userPasswordTextField.delegate = delegate
        _userNameTextField.delegate = delegate
        
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
        _userNameTextField.bottomAnchor.constraint(equalTo: _userPasswordTextField.topAnchor, constant: -35).isActive = true
        
        _userPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftOffset).isActive = true
        _userPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: rightOffset).isActive = true
        _userPasswordTextField.bottomAnchor.constraint(equalTo: _sexLabel.topAnchor, constant: -15).isActive = true
        
        _sexLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        _sexLabel.bottomAnchor.constraint(equalTo: _maleButton.topAnchor, constant: -15).isActive = true
        
        _maleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftOffset).isActive = true
        _maleButton.bottomAnchor.constraint(equalTo: _registrationButton.topAnchor, constant: -15).isActive = true
        _maleButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.35).isActive = true
        _maleButton.addTarget(self, action: #selector(maleButtonOnClick), for: .touchUpInside)
        
        _femaleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: rightOffset).isActive = true
        _femaleButton.bottomAnchor.constraint(equalTo: _registrationButton.topAnchor, constant: -15).isActive = true
        _femaleButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.35).isActive = true
        _femaleButton.addTarget(self, action: #selector(femaleButtonOnClick), for: .touchUpInside)
        
        _registrationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftOffset).isActive = true
        _registrationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: rightOffset).isActive = true
        _registrationButton.bottomAnchor.constraint(equalTo: _rememberPassLabel.topAnchor, constant: -10).isActive = true
        _registrationButton.addTarget(self, action: #selector(registerOnClick), for: .touchUpInside)
        
        _rememberPassLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftOffset).isActive = true
        _rememberPassLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: rightOffset).isActive = true
        _rememberPassLabel.bottomAnchor.constraint(equalTo: _cantRememberPassLabel.topAnchor, constant: -10).isActive = true
        
        _cantRememberPassLabel.leadingAnchor.constraint(equalTo: _rememberPassLabel.leadingAnchor).isActive = true
        _cantRememberPassLabel.trailingAnchor.constraint(equalTo: _rememberPassLabel.trailingAnchor).isActive = true
        _cantRememberPassLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                    constant: -10).isActive = true
    }
}
