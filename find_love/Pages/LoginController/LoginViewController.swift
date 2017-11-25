import UIKit
import UIView_Shake

class LoginViewController: CommonViewController {

    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterKeyboardObservers()
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        setupViews()
        registerKeyboardObserversWith(offset: 50)
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
        textField.text = "Bin@gmail.com"
        textField.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight(0.2))
        textField.adjustsFontSizeToFitWidth = true
        
        return textField
    }()
    
    private let _userPasswordTextField: UITextField = {
        let textField = UnderlinedTextField(xOffset: 0, yOffset: 7)
        textField.defaultInitilization(hint: "Ваш пароль")
        textField.text = "123123"
        textField.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight(0.2))
        textField.adjustsFontSizeToFitWidth = true
        textField.isSecureTextEntry = true
        
        return textField
    }()
    
    private let _loginButton: UIButton = {
        let button = UIButton()
        button.filledCornerInitilization(color: UIColor.red, title: "ВХОД")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight(0.2))
        
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        return button
    }()
    
    private let _resetPasswordButton: UIButton = {
        let button = UIButton()
        button.filledCornerInitilization(color: UIColor.red,
                                         title: "Я ЗАБЫЛ(А) ПАРОЛЬ")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight(0.2))
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        
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
    private lazy var _presenter = LoginPresenter(view: self)
    
    private func setupViews() {
        _emailTextField.font = _emailTextField.font?.withSize(0.037 * view.frame.height)
        _userPasswordTextField.font = _userPasswordTextField.font?.withSize(0.037 * view.frame.height)
        _resetPasswordButton.titleLabel?.font = _resetPasswordButton.titleLabel?.font.withSize(0.034 * view.frame.height)
        _loginButton.titleLabel?.font = _loginButton.titleLabel?.font.withSize(0.034 * view.frame.height)
        _forgotPassLabel.font = _forgotPassLabel.font.withSize(0.03 * view.frame.height)
        _refreshPassLabel.font = _refreshPassLabel.font.withSize(0.02 * view.frame.height)
        
        _emailTextField.delegate = _userNameDelegate
        _userPasswordTextField.delegate = _userNameDelegate
        
        view.addSubview(_appIconImageView)
        view.addSubview(_emailTextField)
        view.addSubview(_userPasswordTextField)
        view.addSubview(_loginButton)
        view.addSubview(_resetPasswordButton)
        view.addSubview(_forgotPassLabel)
        view.addSubview(_refreshPassLabel)
        
        let leftOffset: CGFloat = 40
        let rightOffset: CGFloat = -40
        
        _appIconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        _appIconImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        _appIconImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        _appIconImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
        
        _emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftOffset).isActive = true
        _emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: rightOffset).isActive = true
        _emailTextField.bottomAnchor.constraint(equalTo: _userPasswordTextField.topAnchor, constant: -30).isActive = true
        
        _userPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftOffset).isActive = true
        _userPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: rightOffset).isActive = true
        _userPasswordTextField.bottomAnchor.constraint(equalTo: _loginButton.topAnchor, constant: -45).isActive = true
        
        _loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftOffset).isActive = true
        _loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: rightOffset).isActive = true
        _loginButton.bottomAnchor.constraint(equalTo: _resetPasswordButton.topAnchor, constant: -10).isActive = true
        _loginButton.addTarget(self, action: #selector(loginOnClick), for: .touchUpInside)
        
        _resetPasswordButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftOffset).isActive = true
        _resetPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: rightOffset).isActive = true
        _resetPasswordButton.bottomAnchor.constraint(equalTo: _forgotPassLabel.topAnchor, constant: -35).isActive = true
        _resetPasswordButton.addTarget(self, action: #selector(resetPasswordOnClick), for: .touchUpInside)
        
        _forgotPassLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftOffset).isActive = true
        _forgotPassLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: rightOffset).isActive = true
        _forgotPassLabel.bottomAnchor.constraint(equalTo: _refreshPassLabel.topAnchor, constant: -5).isActive = true
        
        _refreshPassLabel.leadingAnchor.constraint(equalTo: _forgotPassLabel.leadingAnchor).isActive = true
        _refreshPassLabel.trailingAnchor.constraint(equalTo: _forgotPassLabel.trailingAnchor).isActive = true
        _refreshPassLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
    }
    
    @objc private func loginOnClick() {
        var loginAllowed = true

        let loginEmail = _emailTextField.text
        if loginEmail == nil || loginEmail!.isEmpty {
            loginAllowed = false
            _emailTextField.shake(3, withDelta: 8, speed: 0.05)
        }
        
        let password = _userPasswordTextField.text
        if password == nil || password!.isEmpty {
            loginAllowed = false
            _userPasswordTextField.shake(3, withDelta: 8, speed: 0.05)
        }
        
        if loginAllowed {
            _presenter.checkAccount(email: loginEmail!, password: password!)
        }
    }

    
    func validLogin() {
        let listController = FormListViewController()
        navigationController?.pushViewController(listController, animated: true)
    }
    
    func errorLogin(message: String) {
        let alert = customizedAlertController(title: "Ошибка", description: message)
        alert.addAction(customizedAlertAction(title: "OK"))
        
        present(alert, animated: true)
    }
    
    @objc private func resetPasswordOnClick() {
        navigationController?.pushViewController(RegistrationViewController(), animated: true)
    }
}

