import UIKit

class RulesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        
    }
    
    private func setupViews() {
        createRule(text: "Мы не считаем секс изменой это авыапывпывп пыв пыв пы вывп вып пыв пып")
    }
    
    
    private func createRule(text: String) {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 4
        
        let secLabel = UILabel()
        secLabel.textColor = UIColor.white
        secLabel.text = text + " HUI "
        secLabel.translatesAutoresizingMaskIntoConstraints = false
        secLabel.numberOfLines = 4
        
        view.addSubview(label)
        view.addSubview(secLabel)
        
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        
        secLabel.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 5).isActive = true
        secLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        secLabel.topAnchor.constraint(equalTo: label.topAnchor, constant: 10).isActive = true
    }
}
