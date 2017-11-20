import UIKit
import Pages

class MyPageView: PagesController {
    var currentPageIndex = 0
    
    override func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed else { return }
        currentPageIndex = (pageViewController.viewControllers!.first! as! FormImagePage).id
    }
}


class FormListViewController: CommonViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar(title: "Анкеты")
        
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
    
    private let _likeButton: UIButton = {
        let button = UIButton()
        button.filledCornerInitilization(color: UIColor.red, title: "Мне нравится", cornerRadius: 33)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight(0.5))
        
        return button
    }()
    
    private let _appIconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "app_icon"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let _messageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "message"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let _settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "settings_1"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let _pageView: MyPageView = {
        var pages = [UIViewController]()
        let _stickersNames = ["settings", "app_icon", "mask_3",
                                      "mask_4", "mask_5", "mask_6",
                                      "mask_7", "mask_8", "mask_9",
                                      "mask_10"]
        
        var i = 1
        for image in _stickersNames {
            let page = FormImagePage()
            page.avatarImage.image = UIImage(named: image)
            page.id = i
            pages.append(page)
            i += 1
        }
        
        let pagesController = MyPageView(pages)
        pagesController.showPageControl = false
        
        return pagesController
    }()
    
    private func setupViews() {
        view.addSubview(_appIconImageView)
        view.addSubview(_messageButton)
        view.addSubview(_settingsButton)
        view.addSubview(_likeButton)
        
        self.addChildViewController(_pageView)
        self.view.addSubview(_pageView.view)
        
        _messageButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        _messageButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        _messageButton.widthAnchor.constraint(equalToConstant: 55).isActive = true
        _messageButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        _settingsButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        _settingsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        _settingsButton.widthAnchor.constraint(equalToConstant: 55).isActive = true
        _settingsButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        _appIconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        _appIconImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        _appIconImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
        _appIconImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.12).isActive = true
        
        _pageView.view.translatesAutoresizingMaskIntoConstraints = false
        _pageView.view.topAnchor.constraint(equalTo: _appIconImageView.bottomAnchor).isActive = true
        _pageView.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.63).isActive = true
        _pageView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        _pageView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        _likeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35).isActive = true
        _likeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35).isActive = true
        _likeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        _likeButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        _likeButton.addTarget(self, action: #selector(likeOnClick), for: .touchUpInside)
        
        _pageView.didMove(toParentViewController: self)
    }
    
    @objc private func messagesOnClick() {
        print(_pageView.currentIndex)
    }
    
    @objc private func settingsOnClick() {
        
    }
    
    @objc private func likeOnClick() {
        print(_pageView.currentPageIndex)
    }
}
