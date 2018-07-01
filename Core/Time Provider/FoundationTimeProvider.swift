import Foundation

class FoundationTimeProvider: TimeProvider {
    var currentTime: Double { return Date().timeIntervalSince1970 }
}
