import UIKit


class GiftViewController: CommonViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        setupViews()
    }
    

    private let _giftLabel: UILabel = {
        let label = UILabel()
        label.text = "Подарок"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 27)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let _giftImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = #imageLiteral(resourceName: "gift")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let _weGiveLabel: UILabel = {
        let label = UILabel()
        label.text = "Как новому пользователю мы дарим вам 7 дней пользования приложения"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 23)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private let _freeLabel: UILabel = {
        let label = UILabel()
        label.text = "БЕСПЛАТНО"
        label.textColor = UIColor.orange
        label.font = UIFont.systemFont(ofSize: 23)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let _joyLabel: UILabel = {
        let label = UILabel()
        label.text = "Получайте удовольствие от новых знакомств!"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 23)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private let _agreeButton: UIButton = {
        let button = UIButton()
        button.filledCornerInitilization(color: UIColor.orange, title: "Принять", cornerRadius: 0)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight(0.4))
        
        return button
    }()
    

    private func setupViews() {
        view.addSubview(_giftLabel)
        view.addSubview(_giftImageView)
        view.addSubview(_weGiveLabel)
        view.addSubview(_freeLabel)
        view.addSubview(_joyLabel)
        view.addSubview(_agreeButton)
        
        _giftLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        _giftLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        _giftImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        _giftImageView.topAnchor.constraint(equalTo: _giftLabel.bottomAnchor, constant: 20).isActive = true
        _giftImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.34).isActive = true
        
        _weGiveLabel.topAnchor.constraint(equalTo: _giftImageView.bottomAnchor, constant: 10).isActive = true
        _weGiveLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        _weGiveLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        
        _freeLabel.topAnchor.constraint(equalTo: _weGiveLabel.bottomAnchor, constant: 5).isActive = true
        _freeLabel.centerXAnchor.constraint(equalTo: _weGiveLabel.centerXAnchor).isActive = true
        
        _joyLabel.topAnchor.constraint(equalTo: _freeLabel.bottomAnchor, constant: 5).isActive = true
        _joyLabel.leadingAnchor.constraint(equalTo: _weGiveLabel.leadingAnchor).isActive = true
        _joyLabel.trailingAnchor.constraint(equalTo: _weGiveLabel.trailingAnchor).isActive = true
        
        _agreeButton.topAnchor.constraint(equalTo: _joyLabel.bottomAnchor, constant: view.frame.height * 0.06).isActive = true
        _agreeButton.leadingAnchor.constraint(equalTo: _weGiveLabel.leadingAnchor).isActive = true
        _agreeButton.trailingAnchor.constraint(equalTo: _weGiveLabel.trailingAnchor).isActive = true
        _agreeButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.09).isActive = true
        _agreeButton.addTarget(self, action: #selector(agreeOnClick), for: .touchUpInside)
    }
    
    
    @objc private func agreeOnClick() {
        navigationController?.pushViewController(FormListViewController(), animated: true)
    }
}
