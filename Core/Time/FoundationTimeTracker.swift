import Foundation

class FoundationTimeTracker: TimeTracker {

    var currentTime: Double {
        return Date().timeIntervalSince1970
    }

    var startTime: Double {
        return startDate?.timeIntervalSince1970 ?? 0
    }

    private var startDate: Date?

    func start() {
        startDate = Date()
    }
}
