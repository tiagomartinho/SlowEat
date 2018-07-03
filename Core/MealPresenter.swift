class MealPresenter {

    weak var trackingView: MealTrackingView?
    weak var controlsView: MealControlsView?

    private let timeTracker: TimeTracker
    private var timer: Timer
    private let mealTransfer: MealTransfer

    init(timeTracker: TimeTracker,
         timer: Timer,
         mealTransfer: MealTransfer) {
        self.timeTracker = timeTracker
        self.timer = timer
        self.mealTransfer = mealTransfer
    }

    func startMeal() {
        timeTracker.start()
    }

    func stopMeal() {
        let meal = Meal(startTime: timeTracker.startTime,
                        endTime: timeTracker.currentTime)
        mealTransfer.transfer(meal: meal)
        controlsView?.showSummaryView()
    }

    func activateViewUpdates() {
        timer.delegate = self
        timer.start()
    }

    func deactivateViewUpdates() {
        timer.stop()
    }
}

extension MealPresenter: TimerDelegate {
    func tick() {
        let time = timeTracker.currentTime - timeTracker.startTime
        let timeFormatted = TimeFormatter.format(time)
        trackingView?.show(mealTime: timeFormatted)
    }
}
