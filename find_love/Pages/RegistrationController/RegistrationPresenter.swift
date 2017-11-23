import Alamofire

final class RegistrationPresenter {
    private let _view: RegistrationViewController
    private let _registerURL = "http://boobs.hd2be.com/api/profile/register"
    
    required init(view: RegistrationViewController) {
        _view = view
    }
    
    func registerUser(email: String, password: String, name: String) {
        let params: Parameters = ["email": email, "password": password, "name": name]
        
        
        Alamofire.request(_registerURL, method: .post, parameters: params).responseJSON { [unowned self] response -> Void in
            guard let json = response.result.value as? [String: Any] else {
                if let network =  NetworkReachabilityManager(), !network.isReachable {
                    self.errorLogin(errorField: "network")
                } else {
                    self.errorLogin()
                }
                
                return
            }
            
            if let data = json["data"] as? [String: Any],
                let token = data["token"] as? String {
                self.validLogin(token: token)
            } else if
                let error = json["errors"] as? NSArray,
                let errorMessage = (error[0] as? NSDictionary),
                let errorField = errorMessage["field"] as? String {
                
                self.errorLogin(errorField: errorField)
            }
        }
    }
    
    private func errorLogin(errorField: String = "") {
        var message: String
        
        switch errorField {
        case "password":
            message = "Пароль должен быть длинее 6 символов."
            break;
        case "email":
            message = "Неверная почта, либо она уже зарегестрирована."
            break;
        case "network":
            message = "Ошибка подключения к интернету."
            break;
        default:
            message = "Повторите попытку снова попозже."
            break;
        }
        
        DispatchQueue.main.async { [unowned self] () -> Void in
            self._view.invalidLogin(message: message)
        }
    }
    
    private func validLogin(token: String) {
        User.token = token
        
        DispatchQueue.main.async { [unowned self] () -> Void in
            self._view.validLogin()
        }
    }
}
