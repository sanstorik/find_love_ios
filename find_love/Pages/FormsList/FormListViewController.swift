import UIKit
import SCPageViewController
import SCScrollView

class FormListViewController: CommonViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar(title: "Анкеты")
        
        let message = UIBarButtonItem(image: UIImage(named: "message"), style: .plain,
                                     target: self, action: #selector(messagesOnClick))
        
        let settings = UIBarButtonItem(image: UIImage(named: "settings"), style: .plain,
                                      target: self, action: #selector(settingsOnClick))
        navigationItem.leftBarButtonItem = message
        navigationItem.rightBarButtonItem = settings
        
        if FormListViewController.forceResetForms {
            isUploadingImagesAllowed = true
            _presenter.initialLoadForms()
            
            FormListViewController.forceResetForms = false
            updateLikeButtonState()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        _presenter.initialLoadForms()
        setupViews()
        updateLikeButtonState()
    }
    
    private let _likeButton: UIButton = {
        let button = UIButton()
        button.filledCornerInitilization(color: UIColor.red, title: "Мне нравится", cornerRadius: 33)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight(0.5))
        
        return button
    }()
    
    private let _likeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Пока на вашу симпатию не ответят взаимностью, вы не сможете отправлять сообщения."
        label.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight(0.2))
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.alpha = 0
        label.numberOfLines = 3
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private let _appIconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "app_icon"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let _settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "settings"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let _messageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "message"), for: .normal)
        button.contentMode = .scaleToFill
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let pageView: SCPageViewController = {
        let pagesController = SCPageViewController()
        pagesController.setLayouter(SCSlidingPageLayouter(), animated: false, completion: nil)
        pagesController.easingFunction = SCEasingFunction(type: .bounceEaseIn)
        
        return pagesController
    }()
    
    static var forceResetForms = false
    private lazy var _presenter = FormListPresenter(view: self)
    var isUploadingImagesAllowed = true

    var _isLikeButtonActive = true
    
    
    private func setupViews() {
        pageView.delegate = self
        pageView.dataSource = self
        
        view.addSubview(_likeButton)
        view.addSubview(_likeLabel)
        
        self.addChildViewController(pageView)
        self.view.addSubview(pageView.view)
        
        pageView.view.translatesAutoresizingMaskIntoConstraints = false
        pageView.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        pageView.view.bottomAnchor.constraint(equalTo: _likeButton.topAnchor, constant: -30).isActive = true
        pageView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pageView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        _likeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35).isActive = true
        _likeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35).isActive = true
        _likeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        _likeButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.12).isActive = true
        _likeButton.addTarget(self, action: #selector(likeOnClick), for: .touchUpInside)
        
        _likeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60).isActive = true
        _likeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60).isActive = true
        _likeLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        
        pageView.didMove(toParentViewController: self)
    }
    
    
    @objc private func messagesOnClick() {
        let messagesView = MessageLikesViewController()
        navigationController?.pushViewController(messagesView, animated: true)
    }
    
    
    @objc private func settingsOnClick() {
        let settings = SettingsViewController()
        navigationController?.pushViewController(settings, animated: true)
    }
    
    
    @objc private func likeOnClick() {
        guard let page = pageView.viewControllerForPage(at: pageView.currentPage) as? FormImagePage,
            let user = page.user else {
                return
        }
        
        hideLikeButton()
        _presenter.like(user: user)
    }
    
    
    private func hideLikeButton() {
        _likeButton.fadeAnimation(toAlpha: 0, duration: 0.3)
        _likeButton.isUserInteractionEnabled = false
        
        _likeLabel.fadeAnimation(toAlpha: 1, duration: 0.3)
        _isLikeButtonActive = false
    }
    
    
    private func showLikeButton() {
        _likeButton.fadeAnimation(toAlpha: 1, duration: 0.3)
        _likeButton.isUserInteractionEnabled = true
        
        _likeLabel.fadeAnimation(toAlpha: 0, duration: 0.3)
        _isLikeButtonActive = true
    }
    
    
    func errorNetwork() {
        alert(message: "Не удалось загрузить анкеты. Проверьте подключение к интернету.")
    }
    
    
    func errorNoForms() {
        alert(message: "В вашем городе пока что нет анкет.")
    }
    
    
    private func alert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default))
        
        present(alert, animated: true)
    }
}


extension FormListViewController: SCPageViewControllerDataSource, SCPageViewControllerDelegate {
    func numberOfPages(in pageViewController: SCPageViewController!) -> UInt {
        return UInt(_presenter.controllers.count)
    }
    
    func pageViewController(_ pageViewController: SCPageViewController!, viewControllerForPageAt pageIndex: UInt) -> UIViewController! {
        if (pageIndex == _presenter.controllers.count - 2 && isUploadingImagesAllowed) {
            _presenter.loadAdditionalForms()
        }
        
        let controller = _presenter.controllers[Int(pageIndex)] as! FormImagePage
        controller.reportOnClickEvent = { [unowned self] user -> Void in
            self._presenter.report(user: user)
            self._presenter.controllers.remove(at: Int(pageIndex))
            self.pageView.reloadData()
        }
        
        return controller
    }
    
    func pageViewController(_ pageViewController: SCPageViewController!, didNavigateToPageAt pageIndex: UInt) {
        updateLikeButtonState()
    }
    
    private func updateLikeButtonState() {
        guard let page = pageView.viewControllerForPage(at: pageView.currentPage) as? FormImagePage,
            let user = page.user else {
                return
        }
        
        if !_presenter.didUserLike(user: user) && !_isLikeButtonActive {
            showLikeButton()
        } else if _presenter.didUserLike(user: user) && _isLikeButtonActive {
            hideLikeButton()
        }
    }
}
