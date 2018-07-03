import Foundation

class FoundationTimer: Timer {

    weak var delegate: TimerDelegate?

    private var timer: Foundation.Timer?

    func start() {
        timer = Foundation.Timer.scheduledTimer(timeInterval: 0.5,
                                                target: self,
                                                selector: #selector(update),
                                                userInfo: nil,
                                                repeats: true)
        timer?.tolerance = 0.5
    }

    func stop() {
        timer?.invalidate()
        timer = nil
    }

    @objc func update() {
        delegate?.tick()
    }
}
