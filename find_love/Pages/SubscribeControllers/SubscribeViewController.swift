import UIKit

class SubscribeViewController: CommonViewController  {
    
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
    
    private let _topLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 27, weight: UIFont.Weight(0.2))
        label.text = "Получи доступ в мир соблазна"
        label.textColor = UIColor.white
        label.numberOfLines = 2
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let _exitButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "delete").withRenderingMode(.alwaysTemplate), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.white
        
        return button
    }()
    
    private let _agreeButton: UIButton = {
        let button = UIButton()
        button.filledCornerInitilization(color: UIColor.orange, title: "Принимаю", cornerRadius: 0)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight(0.4))
        
        return button
    }()
    
    
    private func setupViews() {
        _topLabel.font = _topLabel.font.withHeightConstant(multiplier: 0.037, view: view)
        _agreeButton.titleLabel?.font = _agreeButton.titleLabel?.font.withHeightConstant(multiplier: 0.034, view: view)
        
        view.addSubview(_exitButton)
        view.addSubview(_topLabel)
        view.addSubview(_agreeButton)

        _exitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        _exitButton.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07).isActive = true
        _exitButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07).isActive = true
        _exitButton.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 30).isActive = true
        _exitButton.addTarget(self, action: #selector(exitOnClick), for: .touchUpInside)
        
        _topLabel.leadingAnchor.constraint(equalTo: _exitButton.trailingAnchor, constant: 20).isActive = true
        _topLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60).isActive = true
        _topLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        
        let first = createLabelBelow(view: _topLabel, text: "Безлимитное количество анкет", offsetY: view.frame.height * 0.06)
        let second = createLabelBelow(view: first, text: "Безлимитное продление заявки")
        let third = createLabelBelow(view: second, text: "Безлимитное количество лайков")
        let fourth = createLabelBelow(view: third, text: "Безлимитное продление сообщений")
        let fifth = createLabelBelow(view: fourth, text: "Режим невидимка")
        
        _agreeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        _agreeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        _agreeButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        _agreeButton.topAnchor.constraint(equalTo: fifth.bottomAnchor, constant: 40).isActive = true
        _agreeButton.addTarget(self, action: #selector(buyOnClick), for: .touchUpInside)
    }
    
    
    private func createLabelBelow(view: UIView, text: String, offsetY: CGFloat = 20) -> UIView {
        let heart = UIImageView(image: #imageLiteral(resourceName: "heartOne").withRenderingMode(.alwaysTemplate))
        heart.tintColor = UIColor.orange
        heart.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(heart)
        
        heart.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 38).isActive = true
        heart.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.042).isActive = true
        heart.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.035).isActive = true
        heart.topAnchor.constraint(equalTo: view.bottomAnchor, constant: offsetY - 3).isActive = true
        
        let label = UILabel()
        self.view.addSubview(label)
        
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(0.2))
        label.font = label.font.withHeightConstant(multiplier: 0.028, view: self.view)
        label.text = text
        label.textColor = UIColor.white
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.leadingAnchor.constraint(equalTo: heart.trailingAnchor, constant: 4).isActive = true
        label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        label.topAnchor.constraint(equalTo: view.bottomAnchor, constant: offsetY).isActive = true

        return label
    }
    
    
    @objc private func exitOnClick() {
        navigationController?.pushViewController(GiftViewController(), animated: true)
    }
    
    @objc private func buyOnClick() {
        navigationController?.pushViewController(FormListViewController(), animated: true)
    }
}
