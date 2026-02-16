
import Foundation

enum LoginResult {
    case success
    case emptyLogin
    case emptyPassword
    case wrongCredentials
    case shortPassword
    case invalidEmail
}

class LoginService {
    static let shared = LoginService()
    private var validUser: User?
    
    private init() {
        self.validUser = loadUser()
    }
    
    private func loadUser() -> User? {
        guard let url = Bundle.main.url(forResource: "User", withExtension: "json"),
              let data = try? Data(contentsOf: url) else { return nil }
        return try? JSONDecoder().decode(User.self, from: data)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func authorize(login: String?, pass: String?) -> LoginResult {
        
        let textLogin = login?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let textPass = pass?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if textLogin.isEmpty { return .emptyLogin }
        if !isValidEmail(textLogin) { return .invalidEmail }
        if textPass.isEmpty { return .emptyPassword }
        if textPass.count < 6 { return .shortPassword }
        
        guard let user = validUser else { return .wrongCredentials }
        
        if textLogin == user.login && textPass == user.password {
            return .success
        } else {
            return .wrongCredentials
        }
    }
}
