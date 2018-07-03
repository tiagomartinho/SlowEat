protocol TimeTracker {
    var currentTime: Double { get }
    var startTime: Double { get }
    func start()
}
