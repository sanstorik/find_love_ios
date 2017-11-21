import UIKit

class LikeCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    private let _avatarImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "settings_1")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        
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

    
    private let _messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "я нравлюсь"
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(0.3))
        label.numberOfLines = 1
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let _heartImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "heartOne")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        backgroundColor = UIColor.black
        
        addSubview(_avatarImageView)
        addSubview(_userNameLabel)
        addSubview(_heartImageView)
        addSubview(_messageLabel)
        
        _avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        _avatarImageView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        _avatarImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        _userNameLabel.leadingAnchor.constraint(equalTo: _avatarImageView.trailingAnchor, constant: 10).isActive = true
        _userNameLabel.topAnchor.constraint(equalTo: _avatarImageView.topAnchor).isActive = true
        
        _heartImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25).isActive = true
        _heartImageView.topAnchor.constraint(equalTo: _userNameLabel.bottomAnchor).isActive = true
        _heartImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        _heartImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        _messageLabel.leadingAnchor.constraint(equalTo: _userNameLabel.leadingAnchor).isActive = true
        _messageLabel.topAnchor.constraint(equalTo: _heartImageView.bottomAnchor).isActive = true
        _messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
}

