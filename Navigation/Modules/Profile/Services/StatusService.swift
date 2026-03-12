
import Foundation

enum StatusError: Error {
    case empty
}

final class StatusService {
    static let shared = StatusService()
    private init() {}
    
    func validateStatus(_ status: String?) throws -> String {
        let trimmedStatus = status?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if trimmedStatus.isEmpty {
            throw StatusError.empty
        }
        return trimmedStatus
    }
}

