import UIKit

class MessageCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    private let _avatarImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "image_placeholder")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 20
        image.layer.masksToBounds = true
        
        return image
    }()
    
    private let _userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.text = "Вика"
        label.font = UIFont.systemFont(ofSize: 24)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let _timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "14:88"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(0.2))
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let _messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "приветик) я з небеснои сотни не ну а шо"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(0.2))
        label.numberOfLines = 1
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    private let _deleteMessageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "delete")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.contentMode = .scaleToFill
        button.tintColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        backgroundColor = UIColor.black
        
        addSubview(_avatarImageView)
        addSubview(_userNameLabel)
        addSubview(_timeLabel)
        addSubview(_messageLabel)
        addSubview(_deleteMessageButton)
        
        _avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        _avatarImageView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        _avatarImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        _userNameLabel.leadingAnchor.constraint(equalTo: _avatarImageView.trailingAnchor, constant: 15).isActive = true
        _userNameLabel.topAnchor.constraint(equalTo: _avatarImageView.topAnchor).isActive = true
        
        _timeLabel.leadingAnchor.constraint(equalTo: _userNameLabel.leadingAnchor).isActive = true
        _timeLabel.topAnchor.constraint(equalTo: _userNameLabel.bottomAnchor, constant: 10).isActive = true
        
        _messageLabel.leadingAnchor.constraint(equalTo: _userNameLabel.leadingAnchor).isActive = true
        _messageLabel.topAnchor.constraint(equalTo: _timeLabel.bottomAnchor, constant: 10).isActive = true
        _messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        
        _deleteMessageButton.trailingAnchor.constraint(equalTo: _messageLabel.trailingAnchor).isActive = true
        _deleteMessageButton.topAnchor.constraint(equalTo: _userNameLabel.topAnchor).isActive = true
        _deleteMessageButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        _deleteMessageButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
