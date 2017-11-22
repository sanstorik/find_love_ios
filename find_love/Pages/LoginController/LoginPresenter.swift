import  UIKit
import Alamofire


final class LoginPresenter {
    private let _login: LoginViewController
    private let _loginURL = "http://boobs.hd2be.com/api/profile/login"
    
    required init(view: LoginViewController) {
        _login = view
    }
    
    func checkAccount(email: String, password: String) {
        let params: Parameters = ["email": email, "password": password]
        
        Alamofire.request(_loginURL, method: .post, parameters: params).responseJSON { [unowned self] response -> Void in
            guard let json = response.result.value as? [String: Any] else {
                if let network = NetworkReachabilityManager(), !network.isReachable {
                    self.errorLoginAsync("Ошибка подключения к интернету.")
                } else {
                    self.errorLoginAsync("Повторите попытку позже.")
                }
                return
            }
            
            if let data = json["data"] as? [String: Any],
                let token = data["token"] as? String {
                self.loginAsync(token: token)
            } else {
                self.errorLoginAsync("Неверные данные.")
            }
        }
    }
    
    private func errorLoginAsync(_ message: String) {
        DispatchQueue.main.async { [unowned self] () -> Void in
            self._login.errorLogin(message: message)
        }
    }
    
    private func loginAsync(token: String) {
        DispatchQueue.main.async { [unowned self] () -> Void in
            self._login.validLogin()
        }
    }
}
