import UIKit
 
class LoginViewController: CommonViewController {

    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar(title: "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        setupViews()
    }
    
    private let _userNameTextField: UITextField = {
        let textField = UnderlinedTextField()
        textField.defaultInitilization(hint: "Ваше имя")
        
        return textField
    }()
    
    private let _userPasswordTextField: UITextField = {
        let textField = UnderlinedTextField()
        textField.defaultInitilization(hint: "Ваш пароль")
        textField.isSecureTextEntry = true
        
        return textField
    }()
    
    private let _loginButton: UIButton = {
        let button = UIButton()
        button.filledCornerInitilization(color: UIColor.red, title: "ВХОД")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        return button
    }()
    
    private let _resetPasswordButton: UIButton = {
        let button = UIButton()
        button.filledCornerInitilization(color: UIColor.red,
                                         title: "Я ЗАБЫЛ(А) ПАРОЛЬ")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        
        return button
    }()
    
    private let _forgotPassLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "Забыли пароль?"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let _refreshPassLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.text = "Создай новый аккаунт, подписка не будет аннулирована"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private let _userNameDelegate = UsernameTextFieldDelegate()
    
    private func setupViews() {
        _userNameTextField.delegate = _userNameDelegate
        _userPasswordTextField.delegate = _userNameDelegate
        
        view.addSubview(_userNameTextField)
        view.addSubview(_userPasswordTextField)
        view.addSubview(_loginButton)
        view.addSubview(_resetPasswordButton)
        view.addSubview(_forgotPassLabel)
        view.addSubview(_refreshPassLabel)
        
        let leftOffset: CGFloat = 40
        let rightOffset: CGFloat = -40
        
        _userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftOffset).isActive = true
        _userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: rightOffset).isActive = true
        _userNameTextField.bottomAnchor.constraint(equalTo: _userPasswordTextField.topAnchor, constant: -30).isActive = true
        
        _userPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftOffset).isActive = true
        _userPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: rightOffset).isActive = true
        _userPasswordTextField.bottomAnchor.constraint(equalTo: _loginButton.topAnchor, constant: -45).isActive = true
        
        _loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftOffset).isActive = true
        _loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: rightOffset).isActive = true
        _loginButton.bottomAnchor.constraint(equalTo: _resetPasswordButton.topAnchor, constant: -10).isActive = true
        
        _resetPasswordButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftOffset).isActive = true
        _resetPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: rightOffset).isActive = true
        _resetPasswordButton.bottomAnchor.constraint(equalTo: _forgotPassLabel.topAnchor, constant: -35).isActive = true
        
        _forgotPassLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftOffset).isActive = true
        _forgotPassLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: rightOffset).isActive = true
        _forgotPassLabel.bottomAnchor.constraint(equalTo: _refreshPassLabel.topAnchor, constant: -5).isActive = true
        
        _refreshPassLabel.leadingAnchor.constraint(equalTo: _forgotPassLabel.leadingAnchor).isActive = true
        _refreshPassLabel.trailingAnchor.constraint(equalTo: _forgotPassLabel.trailingAnchor).isActive = true
        _refreshPassLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
    }
}

