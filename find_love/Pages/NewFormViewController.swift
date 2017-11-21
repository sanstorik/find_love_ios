import UIKit

class NewFormViewController: CommonViewController {

    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar(title: isEditingSession ? "Изменить анкету" : "Новая анкета")
        
        navigationItem.hidesBackButton = !isEditingSession
        
        registerKeyboardObservers(keyboardShowEvent: { [unowned self] _ -> Void in
            self._avatarImageView.fadeAnimation(toAlpha: 0, duration: 1)
            self.animateTitleColor(UIColor.white.withAlphaComponent(0))
        }, keyboardHideEvent: { [unowned self] _ -> Void in
            self._avatarImageView.fadeAnimation(toAlpha: 1, duration: 1)
            self.animateTitleColor(UIColor.white.withAlphaComponent(1))
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterKeyboardObservers()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black
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
    
    private let _cityTextField: UITextField = {
        let textField = UnderlinedSearchTextField(xOffset: 0, yOffset: 7, searchHelpers:
            ["Москва", "Киев", "Владивосток", "Ростов-на-Дону", "Петербург"])
        textField.defaultInitilization(hint: "Укажите город")
        textField.font = UIFont.systemFont(ofSize: 23)
        
        return textField
    }()
    
    private let _avatarImageView: UIImageView = {
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
    
    var isEditingSession = false

    private func setupViews() {
        if isEditingSession {
            _createButton.setTitle("Изменить", for: .normal)
        }
        
        _cityTextField.delegate = _textDelegate
        _countryTextField.delegate = _textDelegate
        _cityTextField.font = _cityTextField.font?.withSize(view.frame.height * 0.033)
        _countryTextField.font = _countryTextField.font?.withSize(view.frame.height * 0.033)
        
        view.addSubview(_avatarImageView)
        view.addSubview(_countryTextField)
        view.addSubview(_cityTextField)
        view.addSubview(_createButton)
        view.addSubview(_noGeoPositionLabel)
        
        _avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        _avatarImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        _avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        _avatarImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.52).isActive = true
        
        _countryTextField.leadingAnchor.constraint(equalTo: _avatarImageView.leadingAnchor).isActive = true
        _countryTextField.trailingAnchor.constraint(equalTo: _avatarImageView.trailingAnchor).isActive = true
        _countryTextField.topAnchor.constraint(equalTo: _avatarImageView.bottomAnchor, constant: 20).isActive = true
        
        _cityTextField.leadingAnchor.constraint(equalTo: _avatarImageView.leadingAnchor).isActive = true
        _cityTextField.trailingAnchor.constraint(equalTo: _avatarImageView.trailingAnchor).isActive = true
        _cityTextField.topAnchor.constraint(equalTo: _countryTextField.bottomAnchor, constant: 20).isActive = true
        
        _createButton.leadingAnchor.constraint(equalTo: _avatarImageView.leadingAnchor).isActive = true
        _createButton.trailingAnchor.constraint(equalTo: _avatarImageView.trailingAnchor).isActive = true
        _createButton.topAnchor.constraint(equalTo: _cityTextField.bottomAnchor, constant: 30).isActive = true
        _createButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        _createButton.addTarget(self, action: #selector(createOnClick), for: .touchUpInside)
        
        _noGeoPositionLabel.leadingAnchor.constraint(equalTo: _avatarImageView.leadingAnchor).isActive = true
        _noGeoPositionLabel.trailingAnchor.constraint(equalTo: _avatarImageView.trailingAnchor).isActive = true
        _noGeoPositionLabel.topAnchor.constraint(equalTo: _createButton.bottomAnchor, constant: 10).isActive = true
    }
    
    public func setEditedImage(image: UIImage?) {
        _avatarImageView.image = image
    }

    private func setupImageTap() {
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(onImageTapped))
        
        _avatarImageView.image = UIImage(named: "image_placeholder")
        _avatarImageView.addGestureRecognizer(imageTap)
        _avatarImageView.isUserInteractionEnabled = true
    }
    
    @objc private func createOnClick() {
        if isEditingSession {
            navigationController?.popViewController(animated: true)
        } else {
            navigationController?.pushViewController(FormListViewController(), animated: true)
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
        
        _avatarImageView.image = image
        
        dismiss(animated: true) { [unowned self] () -> Void in
            let imageEditor = ImageEditorController()
            imageEditor.avatarImage = image
            self.navigationController?.pushViewController(imageEditor, animated: true)
        }
    }
}
