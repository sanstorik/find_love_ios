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
    
    private let _execButton: UIButton = {
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
        view.addSubview(_execButton)
        view.addSubview(_topLabel)
        view.addSubview(_agreeButton)

        _execButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        _execButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        _execButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        _execButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        
        _topLabel.leadingAnchor.constraint(equalTo: _execButton.trailingAnchor, constant: 20).isActive = true
        _topLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60).isActive = true
        _topLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        
        let first = createLabelBelow(view: _topLabel, text: "Безлимитное количество анкет", offsetY: 40)
        let second = createLabelBelow(view: first, text: "Безлимитное продление заявки")
        let third = createLabelBelow(view: second, text: "Безлимитное количество лайков")
        let fourth = createLabelBelow(view: third, text: "Безлимитное продление сообщений")
        let fifth = createLabelBelow(view: fourth, text: "Режим невидимка")
        
        _agreeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        _agreeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        _agreeButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        _agreeButton.topAnchor.constraint(equalTo: fifth.bottomAnchor, constant: 40).isActive = true
    }
    
    private func createLabelBelow(view: UIView, text: String, offsetY: CGFloat = 20) -> UIView {
        let heart = UIImageView(image: #imageLiteral(resourceName: "heartOne").withRenderingMode(.alwaysTemplate))
        heart.tintColor = UIColor.orange
        heart.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(heart)
        
        heart.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 38).isActive = true
        heart.widthAnchor.constraint(equalToConstant: 28).isActive = true
        heart.heightAnchor.constraint(equalToConstant: 25).isActive = true
        heart.topAnchor.constraint(equalTo: view.bottomAnchor, constant: offsetY - 3).isActive = true
        
        let label = UILabel()
        self.view.addSubview(label)
        
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(0.2))
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
}
