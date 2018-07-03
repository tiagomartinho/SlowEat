protocol Timer {
    var delegate: TimerDelegate? { get set }
    func start()
    func stop()
}
