import UIKit
import UIView_Shake
import PMAlertController

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
        registerKeyboardObserversWith(offset: 70)
        registerDismissingKeyboardOnTap()
    }
    
    private let _appIconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "app_icon"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let _emailTextField: UITextField = {
        let textField = UnderlinedTextField(xOffset: 0, yOffset: 7)
        
        textField.defaultInitilization(hint: "Ваш email")
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.keyboardType = .emailAddress
        
        return textField
    }()
    
    private let _nameTextField: UITextField = {
        let textField = UnderlinedTextField(xOffset: 0, yOffset: 7)
        
        textField.defaultInitilization(hint: "Укажите имя")
        textField.font = UIFont.systemFont(ofSize: 20)
        
        return textField
    }()
    
    private let _userPasswordTextField: UITextField = {
        let textField = UnderlinedTextField(xOffset: 0, yOffset: 7)
        
        textField.defaultInitilization(hint: "Придумайте пароль")
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.isSecureTextEntry = true
 
        return textField
    }()
    
    private let _sexLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "УКАЖИТЕ СВОЙ ПОЛ:"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let _maleButton: UIButton = {
        let button = UIButton()
        button.filledCornerInitilization(color: UIColor.darkGray, title: "♂M", cornerRadius: 24)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight(0.2))
        
        return button
    }()
    
    private let _femaleButton: UIButton = {
        let button = UIButton()
        button.filledCornerInitilization(color: UIColor.darkGray, title: "♀Ж", cornerRadius: 24)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight(0.2))
        
        return button
    }()
    
    private let _registrationButton: UIButton = {
        let button = UIButton()
        button.filledCornerInitilization(color: UIColor.darkGray,
                                         title: "Зарегистрироваться",
                                         cornerRadius: 34)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight(0.2))
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        
        return button
    }()
    
    
    private var _sex: Sex?
    private let delegate = UsernameTextFieldDelegate()
    private lazy var _presenter = RegistrationPresenter(view: self)
    
    @objc private func registerOnClick() {
        var areFormsFilled = true
        
        let email = _emailTextField.text
        if email == nil || email!.isEmpty {
            areFormsFilled = false
            _emailTextField.shake(3, withDelta: 8, speed: 0.05)
        }
        
        let password = _userPasswordTextField.text
        if password == nil || password!.isEmpty {
            areFormsFilled = false
            _userPasswordTextField.shake(3, withDelta: 8, speed: 0.05)
        }
        
        let userName = _nameTextField.text
        if userName == nil || userName!.isEmpty {
            areFormsFilled = false
            _nameTextField.shake(3, withDelta: 8, speed: 0.05)
        }
        
        if _sex == nil {
            areFormsFilled = false
            _maleButton.shake(3, withDelta: 8, speed: 0.05)
            _femaleButton.shake(3, withDelta: 8, speed: 0.05)
        }
        
        if areFormsFilled {
            _presenter.registerUser(email: email!, password: password!, name: userName!)
        }
        
    }
    
    func validLogin() {
        let rules = RulesViewController()
        rules.userName = _nameTextField.text
        rules.userEmail = _emailTextField.text
        rules.userSex = _sex
        
        navigationController?.pushViewController(rules, animated: true)
    }
    
    func invalidLogin(message: String) {
        let alert = customizedAlertController(title: "Ошибка", description: message)
        alert.addAction(customizedAlertAction(title: "OК"))
        
        present(alert, animated: true)
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
        _maleButton.titleLabel?.font = _maleButton.titleLabel?.font.withHeightConstant(multiplier: 0.034, view: view)
        _femaleButton.titleLabel?.font = _femaleButton.titleLabel?.font.withHeightConstant(multiplier: 0.034, view: view)
        _sexLabel.font = _sexLabel.font.withHeightConstant(multiplier: 0.037, view: view)
        _emailTextField.font = _emailTextField.font?.withHeightConstant(multiplier: 0.03, view: view)
        _userPasswordTextField.font = _userPasswordTextField.font?.withHeightConstant(multiplier: 0.03, view: view)
        _nameTextField.font = _nameTextField.font?.withHeightConstant(multiplier: 0.03, view: view)
        _registrationButton.titleLabel?.font = _registrationButton.titleLabel?.font.withSize(0.034 * view.frame.height)
        
        _userPasswordTextField.delegate = delegate
        _emailTextField.delegate = delegate
        _nameTextField.delegate = delegate
        
        view.addSubview(_appIconImageView)
        view.addSubview(_emailTextField)
        view.addSubview(_userPasswordTextField)
        view.addSubview(_nameTextField)
        view.addSubview(_sexLabel)
        view.addSubview(_maleButton)
        view.addSubview(_femaleButton)
        view.addSubview(_registrationButton)

        let leftOffset: CGFloat = 40
        let rightOffset: CGFloat = -40
        
        _appIconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        _appIconImageView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        _appIconImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        _appIconImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
        
        _emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: leftOffset).isActive = true
        _emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: rightOffset).isActive = true
        _emailTextField.bottomAnchor.constraint(equalTo: _userPasswordTextField.topAnchor, constant: -25).isActive = true
        
        _userPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftOffset).isActive = true
        _userPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: rightOffset).isActive = true
        _userPasswordTextField.bottomAnchor.constraint(equalTo: _nameTextField.topAnchor, constant: -25).isActive = true
        
        _nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftOffset).isActive = true
        _nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: rightOffset).isActive = true
        _nameTextField.bottomAnchor.constraint(equalTo: _sexLabel.topAnchor, constant: -40).isActive = true
        
        _sexLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        _sexLabel.bottomAnchor.constraint(equalTo: _maleButton.topAnchor, constant: -15).isActive = true
        
        _maleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftOffset).isActive = true
        _maleButton.bottomAnchor.constraint(equalTo: _registrationButton.topAnchor, constant: -25).isActive = true
        _maleButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.35).isActive = true
        _maleButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07).isActive = true
        _maleButton.addTarget(self, action: #selector(maleButtonOnClick), for: .touchUpInside)
        
        _femaleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: rightOffset).isActive = true
        _femaleButton.bottomAnchor.constraint(equalTo: _registrationButton.topAnchor, constant: -25).isActive = true
        _femaleButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.35).isActive = true
        _femaleButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07).isActive = true
        _femaleButton.addTarget(self, action: #selector(femaleButtonOnClick), for: .touchUpInside)
        
        _registrationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftOffset).isActive = true
        _registrationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: rightOffset).isActive = true
        _registrationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
        _registrationButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        _registrationButton.addTarget(self, action: #selector(registerOnClick), for: .touchUpInside)
    }
}
