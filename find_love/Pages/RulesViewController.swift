import UIKit

class RulesViewController: CommonViewController {

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
    
    private let _rulesLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "ПРАВИЛА"
        lbl.textColor = UIColor.white
        lbl.font = UIFont.systemFont(ofSize: 25)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        return lbl
    }()
    
    private let _agreeButton: UIButton = {
        let button = UIButton()
        button.filledCornerInitilization(color: UIColor.red, title: "Принимаю", cornerRadius: 27)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight(0.4))
        
        return button
    }()
    
    var userName: String?
    var userEmail: String?
    var userSex: Sex?

    @objc private func onAgreeClick() {
        let instruction = InstructionViewController()
        instruction.userName = userName
        instruction.userEmail = userEmail
        instruction.userSex = userSex
        
        navigationController?.pushViewController(instruction, animated: true)
    }
    
    private func setupViews() {
        view.addSubview(_rulesLabel)
        view.addSubview(_agreeButton)
        
        _rulesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        _rulesLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        
        let firstRule = createRule(viewAbove: _rulesLabel,
                   text: "Мы не считаем СЕКС изменой, это приятная физиологическая необходимость, как вкусная еда или сладкий сон.",
                   numberOfLines: 4)
        
        let secondRule = createRule(viewAbove: firstRule,
                   text: "Мы нам не хватает СЕКСА, мы вынуждены искать его. Atolin поможет найти его!")
        
        let thirdRule = createRule(viewAbove: secondRule,
                                   text: "В приложении много замужних женщин и мужчин, поэтому наш сервис АНОНИМЕН на 100%.")
        
        let _ = createRule(viewAbove: thirdRule,
                   text: "Размещайте заявку только если вы хотите ИНТИМНОЙ встречи в ближайшее время!")
        
        _agreeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        _agreeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        _agreeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        _agreeButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        _agreeButton.addTarget(self, action: #selector(onAgreeClick), for: .touchUpInside)
    }
    
    
    private func createRule(viewAbove: UIView, text: String, numberOfLines: Int = 3) -> UIView {
        let heartImage = UIImageView()
        heartImage.image = UIImage(named: "heartOne")
        heartImage.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = numberOfLines
        label.text = text
        label.font = UIFont.systemFont(ofSize: 19, weight: UIFont.Weight(0.15))
        label.adjustsFontSizeToFitWidth = true
        
        view.addSubview(heartImage)
        view.addSubview(label)
        
        heartImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        heartImage.topAnchor.constraint(equalTo: viewAbove.bottomAnchor, constant: 15).isActive = true
        heartImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        heartImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        label.leadingAnchor.constraint(equalTo: heartImage.trailingAnchor, constant: 5).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        label.topAnchor.constraint(equalTo: viewAbove.bottomAnchor, constant: 20).isActive = true
        
        return label
    }
}
