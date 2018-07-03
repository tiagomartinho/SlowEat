import Foundation

class FoundationTimeTracker: TimeTracker {

    var currentTime: Double {
        if let time = startDate?.timeIntervalSince1970 {
            return Date().timeIntervalSince1970 - time
        } else {
            return 0
        }
    }

    var startTime: Double {
        if let time = startDate?.timeIntervalSince1970 {
            return time
        } else {
            return 0
        }
    }

    private var startDate: Date?

    func start() {
        startDate = Date()
    }
}
