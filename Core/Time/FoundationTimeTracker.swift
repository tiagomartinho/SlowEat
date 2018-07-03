import Foundation

class FoundationTimeTracker: TimeTracker {

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
