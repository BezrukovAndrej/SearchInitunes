import UIKit

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    enum SettingKeys: String {
        case users
        case activUser
    }
    let defaults = UserDefaults.standard
    let userKey = SettingKeys.users.rawValue
    let activUserKey = SettingKeys.activUser.rawValue
    
    var users: [User] {
        get {
            if let data = defaults.value(forKey: userKey) as? Data {
                return try! PropertyListDecoder().decode([User].self, from: data)
            } else {
                return [User]()
            }
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: userKey)
            }
        }
    }
    
    func saveUser(firstName: String, secondName: String, phone: String, email: String, password: String, age: Date) {
        
        let user = User(firstName: firstName, secondName: secondName, phone: phone, email: email, password: password, age: age)
        users.insert(user, at: 0)
    }
    
    var activUser: User? {
        get {
            if let data = defaults.value(forKey: activUserKey) as? Data {
                return try! PropertyListDecoder().decode(User.self, from: data)
            } else {
                return nil
            }
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: activUserKey)
            }
        }
    }
    
    func saveActivUser(user: User) {
        activUser = user
    }
    
}
