
import Foundation

enum StatusResult {
    case success(newStatus: String)
    case emptyStatus
}

final class StatusService {
    static let shared = StatusService()
    private init() {}
    
    func validateStatus(_ status: String?) -> StatusResult {
        let trimmedStatus = status?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if trimmedStatus.isEmpty {
            return .emptyStatus
        } else {
            return .success(newStatus: trimmedStatus)
        }
    }
}

