import Alamofire

class FormListPresenter {
    private let _searchURL = "http://boobs.hd2be.com/api/profile/partners?"
    private let _view: FormListViewController
    
    var _startingPage = 1
    var _currentPage = 1
    private let _perPage = 6
    var controllers = [UIViewController]()
    
    required init(view: FormListViewController) {
        _view = view
    }
    
    
    func initialLoadForms() {
        controllers.removeAll()
        reloadPageView()
        _view.view.showLoaderFullScreen()
        
        _currentPage = _startingPage
        
        loadFormsAt(page: _startingPage, perPage: _perPage, removeLoader: true) { [unowned self] forms -> Void in
            forms.forEach { userForm in
                if !self.isUserReported(user: userForm) {
                    let imagePage = FormImagePage()
                    imagePage.user = userForm
                    
                    self.controllers.append(imagePage)
                }
            }
            
            self._view.isUploadingImagesAllowed = forms.count >= self._perPage
            self.reloadPageView()
            self._view.updateLikeButtonState()
            
            if forms.count == 0 {
                self.removeLoaderAsync() { [unowned self] () -> () in
                    self.errorNoFormsAsync()
                }
            } else {
                self.removeLoaderAsync()
            }
        }
    }
    
    
    func loadAdditionalForms() {
        _currentPage += 1
        
        loadFormsAt(page: _currentPage, perPage: _perPage) { [unowned self] forms -> Void in
            forms.forEach { userForm in
                if !self.isUserReported(user: userForm) {
                    let imagePage = FormImagePage()
                    imagePage.user = userForm
                    
                    self.controllers.append(imagePage)
                }
            }
            
            self._view.isUploadingImagesAllowed = forms.count >= self._perPage
            self.reloadPageView()
        }
    }
    
    
    private func isUserReported(user: User) -> Bool {
        return UserDefaults.standard.bool(forKey: "reported_\(String(describing: user.id))")
    }
    
    
    func didUserLike(user: User) -> Bool {
        return UserDefaults.standard.bool(forKey: "liked_\(String(describing: user.id))")
    }
    
    
    func like(user: User) {
        UserDefaults.standard.set(true, forKey: "liked_\(String(describing: user.id))")
    }
    
    
    func report(user: User) {
        UserDefaults.standard.set(true, forKey: "reported_\(String(describing: user.id))")
    }
    
    
    private func loadFormsAt(page: Int, perPage: Int, removeLoader: Bool = false, completionHandler: (([User]) -> Void)? = nil) {
        let token = "Bearer " + User.token
        let headers: HTTPHeaders = ["Accept": "application/json",
                                    "Authorization": token]
        let url = _searchURL + "page=\(page)&per_page=\(perPage)"
        
        Alamofire.request(url, headers: headers).responseJSON { [unowned self] response -> Void in
            guard let json = response.result.value as? [String: Any] else {
                if removeLoader {
                    self.removeLoaderAsync() {
                        self.errorLoadAsync()
                    }
                } else {
                    self.errorLoadAsync()
                }
                return
            }
            
            if response.result.isSuccess {
                if let data = json["data"] as? [String: Any],
                    let users = data["items"] as? NSArray {
                    var forms = [User]()
                    
                    users.forEach { user -> Void in
                        if let user = user as? [String: Any] {
                            forms.append(User(name: user["name"] as? String ?? "none",
                                                   email: user["email"] as? String ?? "none" ,
                                                   avatar: Avatar(url: user["avatar"] as? String ?? "none"),
                                                   city: City(id: user["city_id"] as? Int ?? 0,
                                                              name: user["city"] as? String ?? "none"),
                                                   age: user["age"] as? Int ?? 0,
                                                   sex: Sex.stringToSex(user["sex"] as? String ?? "woman"),
                                                   id: user["id"] as? Int ?? 0))
                        }
                    }
                    
                    DispatchQueue.main.async {
                        completionHandler?(forms)
                    }
                }
            } else {
                if removeLoader {
                    self.removeLoaderAsync() {
                        self.errorLoadAsync()
                    }
                } else {
                    self.errorLoadAsync()
                }
            }
        }
    }
    
    private func removeLoaderAsync(completionHandler: (() -> ())? = nil) {
        DispatchQueue.main.async { [unowned self] () -> Void in
            self._view.view.removeLoaderFullScreen(completionHandler)
        }
    }
    
    private func errorLoadAsync() {
        DispatchQueue.main.async { [unowned self] () -> Void in
            self._view.errorNetwork()
        }
    }
    
    private func errorNoFormsAsync() {
        DispatchQueue.main.async { [unowned self] () -> Void in
            self._view.errorNoForms()
        }
    }
    
    private func reloadPageView() {
        _view.pageView.reloadData()
    }
}
