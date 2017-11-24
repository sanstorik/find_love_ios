import Foundation

enum Sex {
    case male, female
    
    var asString: String {
        switch self {
        case .male:
            return "man"
        case .female:
            return "woman"
        }
    }
    
    var asInt: Int {
        switch self {
        case .male:
            return 1
        case .female:
            return 2
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
    
    static func intToSex(_ sex: Int) -> Sex {
        switch sex {
        case 1:
            return Sex.male
        case 2:
            return Sex.female
        default:
            return Sex.male
        }
    }
    
    static func stringToSex(_ sex: String) -> Sex {
        switch sex {
        case "man":
            return Sex.male
        case "woman":
            return Sex.female
        default:
            return Sex.male
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
    var id: Int?
    
    init(name: String, email: String, avatar: Avatar, city: City, age: Int, sex: Sex, id: Int? = nil) {
        self.name = name
        self.email = email
        self.avatar = avatar
        self.city = city
        self.age = age
        self.sex = sex
        self.id = id
    }
}
