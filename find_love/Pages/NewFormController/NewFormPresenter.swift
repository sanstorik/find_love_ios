import Alamofire
import UIKit

class NewFormPresenter {
    private let _view: NewFormViewController
    private let _citiesURL = "http://boobs.hd2be.com/api/cities"
    private let _profileURL = "http://boobs.hd2be.com/api/profile"
    private let _imageURL = "http://boobs.hd2be.com/api/upload"
    private var _cities = [City]()
    
    required init(view: NewFormViewController) {
        _view = view
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
                        let id = city["id"] as? String
                        let cityName = city["name"] as? String
                        
                        self._cities.append(City(id: id ?? "-1", name: cityName ?? "default"))
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
        print("Create form")
        var city = City(id: "-1", name: _view.cityTextField.text!)
        
        for tempCity in _cities {
            if tempCity.name == _view.cityTextField.text {
                city = tempCity
            }
        }
        
        let user = User(name: _view.userName, email: _view.userEmail,
                        avatar: Avatar(url: "test"), city: city, age: 0, sex: _view.userSex)
        
        let params: Parameters = ["name": user.name, "email": user.email, "avatar": user.avatar.url,
                                  "city_id": user.city.id, "age": String(describing: user.age), "sex": user.sex.asString]
        
        let token = "Bearer " + User.token
        let headers: HTTPHeaders = ["Accept": "applications/json",
                                    "Authorization": token]
        
        print(token)
        
        Alamofire.request(_profileURL, method: .post, parameters: params, headers: headers).responseJSON { [unowned self] response -> Void in
            guard let json = response.result.value as? [String: Any] else {
                self.errorRegisterAsync()
                return
            }
            
            if let data = json["data"] as? [String: Any] {
                print(data["id"])
            } else {
                print(response.result)
            }
            
            if response.result.isSuccess {
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
    
    private func updateUserFormSearch(user: User) {
        let token = "Bearer " + User.token
        
        let params: Parameters = ["age_from": "0", "age_to": "0",
                                  "sex": user.sex.opposite]
        let headers: HTTPHeaders = ["Accept": "applications/json",
                                    "Authorization": token]
        
        Alamofire.request(_profileURL, method: .post, parameters: params, headers: headers).responseJSON { [unowned self] response -> Void in
            guard let json = response.result.value as? [String: Any] else {
                self.errorRegisterAsync()
                return
            }
            
            print(json["success"], "update form")
            print(response.result, "update search")
            
            self.validLoginAsync()
        }
    }
    
}
