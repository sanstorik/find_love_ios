import Foundation

enum Sex {
    case male, female
    
    var asString: String {
        switch self {
        case .male:
            return "male"
        case .female:
            return "female"
        }
    }
    
    var opposite: Sex {
        switch self {
        case .male:
            return .female
        case .female:
            return .male
        }
    }
}

class User {
    static var token: String = ""
    
    var name: String
    var email: String
    var avatar: Avatar
    var city: City
    var age: Int
    var sex: Sex
    var biography: String?
    var weight: Int?
    var height: Int?
    
    init(name: String, email: String, avatar: Avatar, city: City, age: Int, sex: Sex) {
        self.name = name
        self.email = email
        self.avatar = avatar
        self.city = city
        self.age = age
        self.sex = sex
    }
}
