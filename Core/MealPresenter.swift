class MealPresenter {

    private weak var view: MealView?
    private let timeTracker: TimeTracker
    private let mealTransfer: MealTransfer

    init(view: MealView,
         timeTracker: TimeTracker,
         mealTransfer: MealTransfer) {
        self.view = view
        self.timeTracker = timeTracker
        self.mealTransfer = mealTransfer
    }

    func startMeal() {
        timeTracker.start()
        view?.showTrackingView()
    }

    func stopMeal() {
        let meal = Meal(startTime: timeTracker.startTime)
        mealTransfer.transfer(meal: meal)
        view?.showSummaryView()
    }
}
