
import Foundation

enum AuthError: Error {
    case emptyLogin
    case emptyPassword
    case wrongCredentials
    case shortPassword
    case invalidEmail
    case bothEmpty
    
    var description: String {
        switch self {
        case .bothEmpty:
            return "Пустой логин и пароль"
        case .emptyLogin:
            return "Пустой логин"
        case .emptyPassword:
            return "Пустой пароль"
        case .invalidEmail:
            return "Некорректный формат e-mail"
        case .shortPassword:
            return "Пароль должен содержать минимум 6 символов"
        case .wrongCredentials:
            return "Неверный логин или пароль"
        }
    }
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
        if !isValidEmail(textLogin) { throw AuthError.invalidEmail }
        
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
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: email)
    }
}
