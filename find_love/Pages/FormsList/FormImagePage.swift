import UIKit

class FormImagePage: UIViewController {
    
    let avatarImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    var id: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(avatarImage)
        avatarImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        avatarImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        avatarImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        avatarImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
