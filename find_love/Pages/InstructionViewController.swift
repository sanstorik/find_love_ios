import UIKit

class InstructionViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        setupViews()
        setupNavigationBar()
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
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight(0.4))
        
        return button
    }()
    
    private func setupNavigationBar() {
        navigationController?.isNavigationBarHidden = true
    }
    
    @objc private func onStartClick() {
        
    }
    
    private func setupViews() {
        view.addSubview(_instructionLabel)
        view.addSubview(_startButton)
        
        _instructionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        _instructionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        
        let firstRule = createRule(viewAbove: _instructionLabel,
                                   text: "Разместите анкету!",
                                   numberOfLines: 1, spacing: 50)
        
        let secondRule = createRule(viewAbove: firstRule,
                                    text: "Система покажет девушек, которые хотят встретится в ближайшее время")
        
        let thirdRule = createRule(viewAbove: secondRule,
                                   text: "Определите кто Вам понравился и укажите симпатию")
        
        let _ = createRule(viewAbove: thirdRule,
                           text: "Если симпатия взаимная - договаривайтесь о встрече", numberOfLines: 2)
        
        _startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        _startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        _startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        _startButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
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
