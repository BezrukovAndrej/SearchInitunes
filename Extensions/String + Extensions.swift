import UIKit

extension String {
    
    enum ValidTypes {
        case name
        case email
        case password
        case phone
    }
    
    enum Regex: String {
        case name = "[a-zA-z]{1,}"
        case email = "[a-zA-Z0-9._]+@[a-zA-Z0-9]+.\\.[a-zA-Z]{2,}"
        case password = "(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).{6,}"
        case phone = "[0-9]{11,11}"
    }
    
    func isValid(validType: ValidTypes) -> Bool {
        let format = "SELF MATCHES %@"
        var regex = ""
        
        switch validType {
        case .name: regex = Regex.name.rawValue
        case .email: regex = Regex.email.rawValue
        case .password: regex = Regex.password.rawValue
        case .phone: regex = Regex.phone.rawValue
        }
        return NSPredicate(format: format, regex).evaluate(with: self)
    }
}
