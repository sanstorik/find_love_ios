import Alamofire
import UIKit

class NewFormPresenter {
    private let _view: NewFormViewController
    private let _citiesURL = "http://boobs.hd2be.com/api/cities"
    private let _profileURL = "http://boobs.hd2be.com/api/profile"
    private let _imageURL = "http://boobs.hd2be.com/api/upload"
    private let _filterURL = "http://boobs.hd2be.com/api/profile/filter-update"
    private var _cities = [City]()
    
    required init(view: NewFormViewController) {
        _view = view
    }
    
    func getUserOnEditSession() {
        let token = "Bearer " + User.token
        
        let headers: HTTPHeaders = ["Accept": "application/json",
                                    "Authorization": token]
        
        Alamofire.request(_profileURL, method: .get, headers: headers).responseJSON { [unowned self] response -> Void in
            guard let json = response.result.value as? [String: Any] else {
                self.errorLoadingDataAsync()
                return
            }
            
            if let userDict = json["data"] as? [String: Any] {
                let user = User(name: userDict["name"] as? String ?? "no name",
                                email: userDict["email"] as? String ?? "no email",
                                avatar: Avatar(url: userDict["avatar"] as? String ?? "none"),
                                city: City(id: userDict["city_id"] as? Int ?? 0,
                                           name: userDict["city"] as? String ?? "none"),
                                age: Int(userDict["age"] as? String ?? "0") ?? 0,
                                sex: Sex.intToSex(userDict["sex"] as? Int ?? 1)
                )
                
                print(user.age)
                print(user.city.id)
                print(user.city.name)
                print(user.name)
                print(user.email)
                print(user.avatar.url)
                print(user.sex)

                DispatchQueue.main.async { [unowned self] () -> Void in
                    self._view.cityTextField.text = user.city.name
                    self._view.userName = user.name
                    self._view.userEmail = user.email
                    self._view.userSex = user.sex
                }
            } else {
                self.errorLoadingDataAsync()
            }
        }
    }
    
    
    func createProfile() {
        if _cities.isEmpty {
            createForm()
            //uploadImage(_view.avatarImageView.image!)
        } else {
            loadCities(updateView: false, avatar: _view.avatarImageView.image)
        }
        
        print("create")
    }
    
    func updateProfile() {
        if _cities.isEmpty {
            createForm()
            //uploadImage(_view.avatarImageView.image!)
        } else {
            loadCities(updateView: false, avatar: _view.avatarImageView.image)
        }
        
        print("update")
    }
    
    func loadCities(updateView: Bool, avatar: UIImage? = nil) {
        Alamofire.request(_citiesURL, method: .get).responseJSON { [unowned self] response -> Void in
            guard let json = response.result.value as? [String: Any] else {
                if !updateView {
                    self.errorRegisterAsync()
                }
                
                return
            }
            
            if let data = json["data"] as? NSArray {
                for cityDict in data {
                    if let city = cityDict as? [String: Any] {
                        let id = city["id"] as? Int
                        let cityName = city["name"] as? String
                        
                        self._cities.append(City(id: id ?? 0, name: cityName ?? "default"))
                    }
                }
            }
            
            if updateView {
                DispatchQueue.main.async { [unowned self] () -> Void in
                    var helpers = [String]()
                    self._cities.forEach( { helpers.append($0.name) } )
                    self._view.cityTextField.searchHelpers = helpers
                }
            } else {
                self.createForm()
                //self.uploadImage(avatar!)
            }
        }
    }
    
    private func uploadImage(_ image: UIImage) {
        guard let data = UIImagePNGRepresentation(image) else {
            print("no image")
            return
        }
        
        let headers: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
        
        Alamofire.upload(multipartFormData: { form in
            form.append(data, withName: "file", fileName: "avatar.png", mimeType: "image/png")
        }, to: _imageURL, headers: headers, encodingCompletion: { result in
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    debugPrint(response)
                    print(response.value as Any)
                    print(response.result)
                }
                
                upload.responseString { response in
                    debugPrint(response)
                }
                
            case .failure(let encodingError):
                print(encodingError)
            }
        })
    }
    
    private func createForm() {
        var city: City?
        
        print("form")
        for tempCity in _cities {
            if tempCity.name == _view.cityTextField.text {
                city = City(id: tempCity.id, name: tempCity.name)
                break;
            }
        }
        
        print(_view.userName)
        print(_view.userEmail)
        
        let user = User(name: _view.userName, email: _view.userEmail,
                        avatar: Avatar(url: "test"), city: city ?? City(id: 0, name: "none selected"),
                        age: 0, sex: _view.userSex)
        
        print(user.sex.asInt)
        let params: Parameters = ["name": user.name, "email": user.email, "avatar": user.avatar.url,
                                  "city_id": user.city.id, "age": String(describing: user.age), "sex": 2]
        

        let token = "Bearer " + User.token
        let headers: HTTPHeaders = ["Accept": "application/json",
                                    "Authorization": token]

        Alamofire.request(_profileURL, method: .post, parameters: params, headers: headers).responseJSON { [unowned self] response -> Void in
            guard let json = response.result.value as? [String: Any] else {
                self.errorRegisterAsync()
                return
            }
            
            print(response.result.value)

            print(response.result, "create Form")
            
            
            if response.result.isSuccess && response.error == nil {
                self.updateUserFormSearch(user: user)
            } else {
                self.errorRegisterAsync()
            }
        }
    }
    
    private func errorRegisterAsync() {
        DispatchQueue.main.async { [unowned self] () -> Void in
            self._view.errorRegister()
        }
    }
    
    private func validLoginAsync() {
        DispatchQueue.main.async { [unowned self] () -> Void in
            self._view.validRegister()
        }
    }
    
    private func errorLoadingDataAsync() {
        DispatchQueue.main.async { [unowned self] () -> Void in
            self._view.errorLoadingData()
        }
    }
    
    private func updateUserFormSearch(user: User) {
        let token = "Bearer " + User.token
        
        let params: Parameters = ["age_from": "0", "age_to": "0",
                                  "sex": user.sex.opposite.asInt,
                                  "city_id": user.city.id]
        let headers: HTTPHeaders = ["Accept": "application/json",
                                    "Authorization": token]
        
        Alamofire.request(_filterURL, method: .post, parameters: params, headers: headers).responseJSON { [unowned self] response -> Void in
            guard let json = response.result.value as? [String: Any] else {
                self.errorRegisterAsync()
                return
            }
            
            print(response.result.value)
            
            self.validLoginAsync()
        }
    }
    
}
