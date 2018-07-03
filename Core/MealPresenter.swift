class MealPresenter {

    weak var trackingView: MealTrackingView?
    weak var controlsView: MealControlsView?

    private let timeTracker: TimeTracker
    private let mealTransfer: MealTransfer

    init(timeTracker: TimeTracker,
         mealTransfer: MealTransfer) {
        self.timeTracker = timeTracker
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

    func update() {
        let time = timeTracker.currentTime - timeTracker.startTime
        let timeFormatted = TimeFormatter.format(time)
        trackingView?.showMealTime(timeFormatted)
    }
}
