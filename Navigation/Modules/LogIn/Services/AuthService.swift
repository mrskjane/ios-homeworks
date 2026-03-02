
import Foundation

enum AuthError: Error {
    case emptyLogin
    case emptyPassword
    case wrongCredentials
    case shortPassword
    case invalidEmail
    case bothEmpty
}

final class AuthService {
    static let shared = AuthService()
    private var validUser: User?
    
    private init() {
        self.validUser = loadUser()
    }
    
    func authorize(login: String?, pass: String?) throws {
            
            let textLogin = login?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            let textPass = pass?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            if textLogin.isEmpty && textPass.isEmpty { throw AuthError.bothEmpty }
            if textLogin.isEmpty { throw AuthError.emptyLogin }
            if !EmailValidator.isValid(textLogin) { throw AuthError.invalidEmail }
            
            if textPass.isEmpty { throw AuthError.emptyPassword }
            if textPass.count < 6 { throw AuthError.shortPassword }
            guard let user = validUser else { throw AuthError.wrongCredentials }
            if textLogin != user.login || textPass != user.password {
                throw AuthError.wrongCredentials
            }
        }
    
    private func loadUser() -> User? {
        guard let url = Bundle.main.url(forResource: "User", withExtension: "json"),
              let data = try? Data(contentsOf: url) else { return nil }
        return try? JSONDecoder().decode(User.self, from: data)
    }
}
