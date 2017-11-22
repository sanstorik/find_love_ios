import Alamofire

class NewFormPresenter {
    private let _view: NewFormViewController
    private let _citiesURL = "http://boobs.hd2be.com/api/cities"
    private let _profileURL = "http://boobs.hd2be.com/api/profile"
    
    required init(view: NewFormViewController) {
        _view = view
    }
    
    func createProfile() {
    }
    
    func loadCities() {
        Alamofire.request(_citiesURL, method: .get).responseJSON { [unowned self] response -> Void in
            guard let json = response.result.value as? [String: Any] else {
                return
            }
            
            var cities = [City]()
            
            if let data = json["data"] as? NSArray {
                for cityDict in data {
                    if let city = cityDict as? [String: Any] {
                        let id = city["id"] as? String
                        let cityName = city["name"] as? String
                        
                        cities.append(City(id: id ?? "-1", name: cityName ?? "default"))
                    }
                }
            }
            
            DispatchQueue.main.async { [unowned self] () -> Void in
                self._view.cities = cities
            }
        }
    }
}
