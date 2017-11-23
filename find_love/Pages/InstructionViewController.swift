import UIKit

class InstructionViewController: CommonViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        setupViews()
    }
    
    private let _instructionLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Инструкция"
        lbl.textColor = UIColor.white
        lbl.font = UIFont.systemFont(ofSize: 32)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        return lbl
    }()
    
    private let _startButton: UIButton = {
        let button = UIButton()
        button.filledCornerInitilization(color: UIColor.red, title: "Начать", cornerRadius: 35)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 29, weight: UIFont.Weight(0.4))
        
        return button
    }()
    
    private let _appIconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "google_maps_girls"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    var userName: String?
    var userEmail: String?
    var userSex: Sex?
    
    @objc private func onStartClick() {
        let form = NewFormViewController()
        form.userName = userName ?? "default"
        form.userEmail = userEmail ?? "default"
        form.userSex = userSex ?? .male
        
        navigationController?.pushViewController(form,  animated: true)
    }
    
    private func setupViews() {
        view.addSubview(_instructionLabel)
        view.addSubview(_startButton)
        view.addSubview(_appIconImageView)
        
        _instructionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        _instructionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        
        let firstRule = createRule(viewAbove: _instructionLabel,
                                   text: "Разместите анкету!",
                                   numberOfLines: 1, spacing: 30)
        
        let secondRule = createRule(viewAbove: firstRule,
                                    text: "Система покажет девушек, которые хотят встретится в ближайшее время")
        
        _appIconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        _appIconImageView.topAnchor.constraint(equalTo: secondRule.bottomAnchor, constant: 30).isActive = true
        _appIconImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.13).isActive = true
        _appIconImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35).isActive = true
        _appIconImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35).isActive = true
        
        let thirdRule = createRule(viewAbove: _appIconImageView,
                                   text: "Определите кто Вам понравился и укажите симпатию", spacing: 30)
        
        let fourthRule = createRule(viewAbove: thirdRule,
                           text: "Если симпатия взаимная - договаривайтесь о встрече", numberOfLines: 2)
        
        _startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        _startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        _startButton.topAnchor.constraint(equalTo: fourthRule.bottomAnchor, constant: 25).isActive = true
        _startButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        _startButton.addTarget(self, action: #selector(onStartClick), for: .touchUpInside)
    }
    
    
    private func createRule(viewAbove: UIView, text: String, numberOfLines: Int = 3,
                            spacing: CGFloat = 20) -> UIView {
        let heartImage = UIImageView()
        heartImage.image = UIImage(named: "heartOne")
        heartImage.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = numberOfLines
        label.text = text
        label.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight(0.05))
        label.font = label.font.withSize(self.view.frame.height * 0.034)
        
        label.adjustsFontSizeToFitWidth = true
        
        view.addSubview(heartImage)
        view.addSubview(label)
        
        heartImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35).isActive = true
        heartImage.topAnchor.constraint(equalTo: viewAbove.bottomAnchor, constant: spacing - 5).isActive = true
        heartImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        heartImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        label.leadingAnchor.constraint(equalTo: heartImage.trailingAnchor, constant: 5).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        label.topAnchor.constraint(equalTo: viewAbove.bottomAnchor, constant: spacing).isActive = true
        
        return label
    }
}
