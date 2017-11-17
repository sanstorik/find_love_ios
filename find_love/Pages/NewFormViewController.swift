import UIKit

class NewFormViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black
        setupViews()
        setupNavigationBar()
        setupImageTap()
    }
    
    private let _countryTextField: UITextField = {
        let textField = UnderlinedTextField()
        textField.defaultInitilization(hint: "Укажите страну")
        textField.keyboardType = .asciiCapable
        textField.font = UIFont.systemFont(ofSize: 23)
        
        return textField
    }()
    
    private let _cityTextField: UITextField = {
        let textField = UnderlinedTextField()
        textField.defaultInitilization(hint: "Укажите город")
        textField.keyboardType = .asciiCapable
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
    
    private func setupViews() {
        _cityTextField.delegate = _textDelegate
        _countryTextField.delegate = _textDelegate
        
        view.addSubview(_avatarImageView)
        view.addSubview(_countryTextField)
        view.addSubview(_cityTextField)
        view.addSubview(_createButton)
        view.addSubview(_noGeoPositionLabel)
        
        _avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        _avatarImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        _avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        _avatarImageView.heightAnchor.constraint(equalToConstant: 320).isActive = true
        
        _countryTextField.leadingAnchor.constraint(equalTo: _avatarImageView.leadingAnchor).isActive = true
        _countryTextField.trailingAnchor.constraint(equalTo: _avatarImageView.trailingAnchor).isActive = true
        _countryTextField.topAnchor.constraint(equalTo: _avatarImageView.bottomAnchor, constant: 20).isActive = true
        
        _cityTextField.leadingAnchor.constraint(equalTo: _avatarImageView.leadingAnchor).isActive = true
        _cityTextField.trailingAnchor.constraint(equalTo: _avatarImageView.trailingAnchor).isActive = true
        _cityTextField.topAnchor.constraint(equalTo: _countryTextField.bottomAnchor, constant: 30).isActive = true
        
        _createButton.leadingAnchor.constraint(equalTo: _avatarImageView.leadingAnchor).isActive = true
        _createButton.trailingAnchor.constraint(equalTo: _avatarImageView.trailingAnchor).isActive = true
        _createButton.topAnchor.constraint(equalTo: _cityTextField.bottomAnchor, constant: 30).isActive = true
        _createButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        _createButton.addTarget(self, action: #selector(createOnClick), for: .touchUpInside)
        
        _noGeoPositionLabel.leadingAnchor.constraint(equalTo: _avatarImageView.leadingAnchor).isActive = true
        _noGeoPositionLabel.trailingAnchor.constraint(equalTo: _avatarImageView.trailingAnchor).isActive = true
        _noGeoPositionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
    }
    
    
    private func setupNavigationBar() {
        navigationItem.title = "Новая анкета"
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.lightGray,
             NSAttributedStringKey.font: UIFont.systemFont(ofSize: 28)]

        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.black
    }
    
    private func setupImageTap() {
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(onImageTapped))
        
        _avatarImageView.image = UIImage(named: "settings")
        _avatarImageView.addGestureRecognizer(imageTap)
        _avatarImageView.isUserInteractionEnabled = true
    }
    
    @objc private func createOnClick() {
        
    }
    
    @objc private func settingsOnClick() {
        
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
        dismiss(animated: true)
    }
}
