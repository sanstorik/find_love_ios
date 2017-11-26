import UIKit
import UIView_Shake
import PMAlertController

class NewFormViewController: CommonViewController {

    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar(title: isEditingSession ? "Изменить анкету" : "Новая анкета")
        
        navigationItem.hidesBackButton = !isEditingSession
        
        registerKeyboardObservers(keyboardShowEvent: { [unowned self] _ -> Void in
            self.avatarImageView.fadeAnimation(toAlpha: 0, duration: 1)
            self.animateTitleColor(UIColor.white.withAlphaComponent(0))
        }, keyboardHideEvent: { [unowned self] _ -> Void in
            self.avatarImageView.fadeAnimation(toAlpha: 1, duration: 1)
            self.animateTitleColor(UIColor.white.withAlphaComponent(1))
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterKeyboardObservers()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black
        
        _presenter.loadCities(updateView: true)
        if isEditingSession {
            _presenter.getUserOnEditSession()
        }
        
        setupViews()
        setupImageTap()
    }
    
    
    private let _countryTextField: UITextField = {
        let textField = UnderlinedSearchTextField(xOffset: 0, yOffset: 7, searchHelpers: ["Россия"])
        textField.text = "Россия"
        textField.isUserInteractionEnabled = false
        textField.defaultInitilization(hint: "Укажите страну")
        textField.font = UIFont.systemFont(ofSize: 23)
        
        return textField
    }()
    
    let cityTextField: UnderlinedSearchTextField = {
        let textField = UnderlinedSearchTextField(xOffset: 0, yOffset: 7)
        textField.defaultInitilization(hint: "Укажите город")
        textField.font = UIFont.systemFont(ofSize: 23)
        
        return textField
    }()
    
    let avatarImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.borderWidth = 2
        image.layer.borderColor = UIColor.white.cgColor
        
        return image
    }()
    
    private let _createButton: UIButton = {
        let button = UIButton()
        button.filledCornerInitilization(color: UIColor.darkGray,
                                         title: "Начать",
                                         cornerRadius: 27)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 31, weight: UIFont.Weight(0.5))
        
        return button
    }()
    
    private let _noGeoPositionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "МЫ НЕ ИСПОЛЬЗУЕМ ГЕОПОЗИЦИОНИРОВАНИЕ, чтобы не выдать ваше местонахождение"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
        
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()

    private let _textDelegate = UsernameTextFieldDelegate()
    private lazy var _presenter = NewFormPresenter(view: self)
    private var _isImageSet = false
    
    var isEditingSession = false
    
    var userName: String = "аноним"
    var userEmail: String = "аноним"
    var userSex: Sex = .male

    private func setupViews() {
        if isEditingSession {
            _createButton.setTitle("Изменить", for: .normal)
            _countryTextField.text = "Россия"
            _isImageSet = true
        }
        
        cityTextField.delegate = _textDelegate
        _countryTextField.delegate = _textDelegate
        cityTextField.font = cityTextField.font?.withSize(view.frame.height * 0.03)
        _countryTextField.font = _countryTextField.font?.withSize(view.frame.height * 0.03)
        _noGeoPositionLabel.font = _noGeoPositionLabel.font?.withHeightConstant(multiplier: 0.017, view: view)
        _createButton.titleLabel?.font = _createButton.titleLabel?.font.withHeightConstant(multiplier: 0.032, view: view)
        
        view.addSubview(avatarImageView)
        view.addSubview(_countryTextField)
        view.addSubview(cityTextField)
        view.addSubview(_createButton)
        view.addSubview(_noGeoPositionLabel)
        
        avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        avatarImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        avatarImageView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: view.frame.height * 0.04).isActive = true
        avatarImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45).isActive = true
        
        _countryTextField.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor).isActive = true
        _countryTextField.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor).isActive = true
        _countryTextField.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 20).isActive = true
        
        cityTextField.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor).isActive = true
        cityTextField.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor).isActive = true
        cityTextField.topAnchor.constraint(equalTo: _countryTextField.bottomAnchor, constant: 20).isActive = true
        
        _createButton.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor).isActive = true
        _createButton.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor).isActive = true
        _createButton.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 30).isActive = true
        _createButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.085).isActive = true
        _createButton.addTarget(self, action: #selector(createOnClick), for: .touchUpInside)
        
        _noGeoPositionLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor).isActive = true
        _noGeoPositionLabel.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor).isActive = true
        _noGeoPositionLabel.topAnchor.constraint(equalTo: _createButton.bottomAnchor, constant: 10).isActive = true
    }
    
    func setEditedImage(image: UIImage?) {
        avatarImageView.image = image
    }
    
    func errorRegister() {
        let alert = customizedAlertController(title: "Ошибка", description: "Не удалось получить данные. Проверьте подключение к интернету и попробуйте снова.")
        
        let action = customizedAlertAction(title: "ОК")
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
    func validRegister() {
        if isEditingSession {
            FormListViewController.forceResetForms = true
            navigationController?.popViewController(animated: true)
        } else {
            let subscribe = SubscribeViewController()
            
            navigationController?.pushViewController(subscribe, animated: true)
        }
    }
    
    func errorLoadingData() {
        let alert = customizedAlertController(title: "Ошибка", description: "Не удалось получить данные. Проверьте подключение к интернету и попробуйте снова.")

        let action = customizedAlertAction(title: "ОК") { [unowned self] () -> Void in
            self.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(action)
        
        present(alert, animated: true)
    }

    private func setupImageTap() {
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(onImageTapped))
        
        avatarImageView.image = UIImage(named: "image_placeholder")
        avatarImageView.addGestureRecognizer(imageTap)
        avatarImageView.isUserInteractionEnabled = true
    }
    
    @objc private func createOnClick() {
        if _presenter.citiesAreEmpty {
            alertTurnInternetOn()
            return;
        }
        
        var isRegistrationAllowed = true
        
        let city = cityTextField.text
        if city == nil || city!.isEmpty || !_presenter.isValidCity() {
            isRegistrationAllowed = false
            cityTextField.shake(3, withDelta: 8, speed: 0.05)
        }
        
        let country = _countryTextField.text
        if country == nil || country!.isEmpty || country != "Россия" {
            isRegistrationAllowed = false
            _countryTextField.shake(3, withDelta: 8, speed: 0.05)
        }
        
        if !_isImageSet {
            isRegistrationAllowed = false
            avatarImageView.shake(3, withDelta: 8, speed: 0.05)
        }
        
        if isRegistrationAllowed {
            if isEditingSession {
                _presenter.updateProfile()
            } else {
                _presenter.createProfile()
            }
        }
    }

    @objc private func onImageTapped() {
        let alert = UIAlertController(title: nil, message: "От качества вашего фото зависит количество положительных откликов", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Камера", style: .default, handler: { [unowned self] action -> Void in
            self.chooseImage(sourceType: .camera)
        } )
        
        let galleryAction = UIAlertAction(title: "Галерея", style: .default, handler: { [unowned self] action -> Void in
            self.chooseImage(sourceType: .photoLibrary)
        } )
        
        let close = UIAlertAction(title: "Отмена", style: .cancel)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alert.addAction(cameraAction)
        }
        
        if let presenter = alert.popoverPresentationController {
            presenter.sourceView = _createButton
            presenter.sourceRect = _createButton.bounds
        }
        
        alert.addAction(galleryAction)
        alert.addAction(close)
        
        present(alert, animated: true)
    }
    
    private func chooseImage(sourceType: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        
        present(imagePicker, animated: true)
    }
    
    private func alertTurnInternetOn() {
        let alert = customizedAlertController(title: "Ошибка", description: "Подключите интернет и нажмите на кнопку продолжить.")
        let action = customizedAlertAction(title: "Продолжить") { [unowned self] () -> Void in
            self._presenter.loadCities(updateView: true)
        }
        
        alert.addAction(action)
        
        present(alert, animated: true)
    }
}


extension NewFormViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        
        avatarImageView.image = image
        
        dismiss(animated: true) { [unowned self] () -> Void in
            let imageEditor = ImageEditorController()
            imageEditor.avatarImage = image
            self._isImageSet = true
            
            self.navigationController?.pushViewController(imageEditor, animated: true)
        }
    }
}
