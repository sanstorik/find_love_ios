import UIKit

class FormImagePage: UIViewController {
    
    private let _avatarImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.image = UIImage(named: "image_placeholder")
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private let _bottomLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        return view
    }()
    
    private let _userName: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "Maru"
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight(0.2))
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let _onlineLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "online"
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight(0.2))
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let _reportButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "info")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var user: User? {
        didSet {
            if let user = self.user {
                _userName.text = user.name
                _avatarImage.downloadImageFrom(url: user.avatar.completeURL)
            }
        }
    }
    
    var reportOnClickEvent: ((User) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        _onlineLabel.font = _onlineLabel.font.withHeightConstant(multiplier: 0.025, view: view)
        _userName.font = _userName.font.withHeightConstant(multiplier: 0.035, view: view)
        
        view.addSubview(_avatarImage)
        view.addSubview(_bottomLine)
        _bottomLine.addSubview(_userName)
        _bottomLine.addSubview(_onlineLabel)
        _bottomLine.addSubview(_reportButton)
        
        _avatarImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        _avatarImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        _avatarImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        _avatarImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        _bottomLine.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        _bottomLine.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        _bottomLine.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        _bottomLine.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.17).isActive = true
        
        _userName.centerXAnchor.constraint(equalTo: _bottomLine.centerXAnchor, constant: -40).isActive = true
        _userName.centerYAnchor.constraint(equalTo: _bottomLine.centerYAnchor).isActive = true
        
        _onlineLabel.leadingAnchor.constraint(equalTo: _userName.trailingAnchor, constant: 20).isActive = true
        _onlineLabel.centerYAnchor.constraint(equalTo: _bottomLine.centerYAnchor).isActive = true
        
        _reportButton.trailingAnchor.constraint(equalTo: _bottomLine.trailingAnchor, constant: -15).isActive = true
        _reportButton.heightAnchor.constraint(equalTo: _bottomLine.heightAnchor, multiplier: 0.5).isActive = true
        _reportButton.widthAnchor.constraint(equalTo: _bottomLine.heightAnchor, multiplier: 0.5).isActive = true
        _reportButton.centerYAnchor.constraint(equalTo: _bottomLine.centerYAnchor).isActive = true
        _reportButton.addTarget(self, action: #selector(reportOnClick), for: .touchUpInside)
    }
    
    @objc private func reportOnClick() {
        let alert = customizedAlertController(title: "", description: "Вы действительно хотите сообщить, что этот пользователь нарушает правила?")
        
        alert.addAction(customizedAlertAction(title: "Нет"))
        alert.addAction(customizedAlertAction(title: "Да") { [unowned self] () -> Void in
            if let user = self.user {
                self.reportOnClickEvent?(user)
            }
        })
        
        present(alert, animated: true)
    }
}
