import UIKit
import UIView_Shake

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
        setupViews()
        setupImageTap()
    }
    
    
    private let _countryTextField: UITextField = {
        let textField = UnderlinedSearchTextField(xOffset: 0, yOffset: 7, searchHelpers:
            ["Россия", "Украина", "Беларусь", "Казахстан", "Китай"])
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
                                         cornerRadius: 30)
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
    
    var isEditingSession = false
    
    var userName: String = ""
    var userEmail: String = ""
    var userSex: Sex = .male

    private func setupViews() {
        if isEditingSession {
            _createButton.setTitle("Изменить", for: .normal)
        }
        
        cityTextField.delegate = _textDelegate
        _countryTextField.delegate = _textDelegate
        cityTextField.font = cityTextField.font?.withSize(view.frame.height * 0.033)
        _countryTextField.font = _countryTextField.font?.withSize(view.frame.height * 0.033)
        
        view.addSubview(avatarImageView)
        view.addSubview(_countryTextField)
        view.addSubview(cityTextField)
        view.addSubview(_createButton)
        view.addSubview(_noGeoPositionLabel)
        
        avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        avatarImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        avatarImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.52).isActive = true
        
        _countryTextField.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor).isActive = true
        _countryTextField.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor).isActive = true
        _countryTextField.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 20).isActive = true
        
        cityTextField.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor).isActive = true
        cityTextField.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor).isActive = true
        cityTextField.topAnchor.constraint(equalTo: _countryTextField.bottomAnchor, constant: 20).isActive = true
        
        _createButton.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor).isActive = true
        _createButton.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor).isActive = true
        _createButton.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 30).isActive = true
        _createButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        _createButton.addTarget(self, action: #selector(createOnClick), for: .touchUpInside)
        
        _noGeoPositionLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor).isActive = true
        _noGeoPositionLabel.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor).isActive = true
        _noGeoPositionLabel.topAnchor.constraint(equalTo: _createButton.bottomAnchor, constant: 10).isActive = true
    }
    
    func setEditedImage(image: UIImage?) {
        avatarImageView.image = image
    }
    
    func errorRegister() {
        let alert = UIAlertController(title: "Ошибка", message: "Не удалось зарегистрировать. Проверьте подключение к интернету.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .cancel))
        
        present(alert, animated: true);
    }
    
    func validRegister() {
        if isEditingSession {
            navigationController?.popViewController(animated: true)
        } else {
            let formList = FormListViewController()
            
            navigationController?.pushViewController(formList, animated: true)
        }
    }

    private func setupImageTap() {
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(onImageTapped))
        
        avatarImageView.image = UIImage(named: "image_placeholder")
        avatarImageView.addGestureRecognizer(imageTap)
        avatarImageView.isUserInteractionEnabled = true
    }
    
    @objc private func createOnClick() {
        var isRegistrationAllowed = true
        
        let city = cityTextField.text
        if city == nil || city!.isEmpty {
            isRegistrationAllowed = false
            cityTextField.shake(3, withDelta: 8, speed: 0.05)
        }
        
        let county = _countryTextField.text
        if county == nil || county!.isEmpty {
            isRegistrationAllowed = false
            _countryTextField.shake(3, withDelta: 8, speed: 0.05)
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
}


extension NewFormViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            NSLog("coulnt find image")
            return
        }
        
        avatarImageView.image = image
        
        dismiss(animated: true) { [unowned self] () -> Void in
            let imageEditor = ImageEditorController()
            imageEditor.avatarImage = image
            self.navigationController?.pushViewController(imageEditor, animated: true)
        }
    }
}