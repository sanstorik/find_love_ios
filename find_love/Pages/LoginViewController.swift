import UIKit

class LoginViewController: UIViewController {

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
        textField.defaultInitilization(hint: "Ваш пароль")
        textField.useUnderline()
        textField.isSecureTextEntry = true
        
        return textField
    }()
    
    private let _loginButton: UIButton = {
        let button = UIButton()
        button.filledCornerInitilization(color: UIColor.red, title: "Вход")
        return button
    }()
    
    private let _resetPasswordButton: UIButton = {
        let button = UIButton()
        button.filledCornerInitilization(color: UIColor.red,
                                         title: "Я забыл(а) пароль")
        
        return button
    }()
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.black
    }
    
    private func setupViews() {
        view.addSubview(_userNameTextField)
        view.addSubview(_userPasswordTextField)
        view.addSubview(_loginButton)
        view.addSubview(_resetPasswordButton)
        
        let leftOffset: CGFloat = 25
        let rightOffset: CGFloat = -25
        
        _userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftOffset).isActive = true
        _userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: rightOffset).isActive = true
        _userNameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        
        _userPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftOffset).isActive = true
        _userPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: rightOffset).isActive = true
        _userPasswordTextField.topAnchor.constraint(equalTo: _userNameTextField.bottomAnchor, constant: 20).isActive = true
        
        _loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftOffset).isActive = true
        _loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: rightOffset).isActive = true
        _loginButton.topAnchor.constraint(equalTo: _userPasswordTextField.bottomAnchor, constant: 50).isActive = true
        
        _resetPasswordButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftOffset).isActive = true
        _resetPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: rightOffset).isActive = true
        _resetPasswordButton.topAnchor.constraint(equalTo: _loginButton.bottomAnchor, constant: 10).isActive = true
    }
}

