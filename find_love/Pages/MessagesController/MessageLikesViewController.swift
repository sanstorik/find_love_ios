import UIKit
import PagingMenuController

class MessageLikesViewController: CommonViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar(title: "Общение")
        
        let settings = UIBarButtonItem(image: UIImage(named: "settings"), style: .plain,
                                       target: self, action: #selector(settingsOnClick))
        
        navigationItem.rightBarButtonItem = settings
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private let _pageView: PagingMenuController = {
        let options = PagingMenuOptions()
        let pagingMenuController = PagingMenuController(options: options)
        pagingMenuController.view.translatesAutoresizingMaskIntoConstraints = false
        
        return pagingMenuController
    }()
    
    private func setupViews() {
        addChildViewController(_pageView)
        view.addSubview(_pageView.view)
        
        _pageView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        _pageView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        _pageView.view.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 7).isActive = true
        _pageView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @objc private func settingsOnClick() {
        navigationController?.pushViewController(SettingsViewController(), animated: true)
    }
}

fileprivate struct MessagesMenuItem: MenuItemViewCustomizable {
    var displayMode: MenuItemDisplayMode {
        return .text(title: MenuItemText(text: "Сообщения"))
    }
}
fileprivate struct LikesMenuItem: MenuItemViewCustomizable {
    var displayMode: MenuItemDisplayMode {
        return .text(title: MenuItemText(text: "Я нравлюсь"))
    }
}

fileprivate struct MenuOptions: MenuViewCustomizable {
    var itemsOptions: [MenuItemViewCustomizable] {
        return [MessagesMenuItem(), LikesMenuItem()]
    }
    
    var displayMode: MenuDisplayMode {
        return .standard(widthMode: .fixed(width: UIScreen.main.bounds.width / 2.5), centerItem: false, 
                         scrollingMode: MenuScrollingMode.pagingEnabled)
    }
}

fileprivate struct PagingMenuOptions: PagingMenuControllerCustomizable {
    var componentType: ComponentType {
        return .all(menuOptions: MenuOptions(), pagingControllers: [MessagesCollectionView(collectionViewLayout: UICollectionViewFlowLayout()), LikesCollectionView(collectionViewLayout: UICollectionViewFlowLayout())])
    }
}
