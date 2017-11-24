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
        _currentPage = _startingPage
        
        loadFormsAt(page: _startingPage, perPage: _perPage) { [unowned self] forms -> Void in
            forms.forEach { userForm in
                let imagePage = FormImagePage()
                imagePage.user = userForm
                
                self.controllers.append(imagePage)
            }
            
            self._view.isUploadingImagesAllowed = forms.count >= self._perPage
            self.reloadPageView()
            
            if forms.count == 0 {
                self.errorNoFormsAsync()
            }
        }
    }
    
    func loadAdditionalForms() {
        _currentPage += 1
        
        loadFormsAt(page: _currentPage, perPage: _perPage) { [unowned self] forms -> Void in
            let formsCountBefore = self.controllers.count
            
            forms.forEach { userForm in
                let imagePage = FormImagePage()
                imagePage.user = userForm
                
                self.controllers.append(imagePage)
            }
            
            self._view.isUploadingImagesAllowed = (self.controllers.count - formsCountBefore) >= self._perPage
            self.reloadPageView()
        }

    }
    
    private func loadFormsAt(page: Int, perPage: Int, completionHandler: (([User]) -> Void)? = nil) {
        let token = "Bearer " + User.token
        let headers: HTTPHeaders = ["Accept": "application/json",
                                    "Authorization": token]
        let url = _searchURL + "page=\(page)&per_page=\(perPage)"
        
        Alamofire.request(url, headers: headers).responseJSON { [unowned self] response -> Void in
            guard let json = response.result.value as? [String: Any] else {
                self.errorLoadAsync()
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
                    
                    print(forms.count, "forms count")
                    
                    DispatchQueue.main.async {
                        completionHandler?(forms)
                    }
                }
            } else {
                self.errorLoadAsync()
            }
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
