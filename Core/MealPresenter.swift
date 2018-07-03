class MealPresenter {

    private let timeTracker: TimeTracker
    private let mealTransfer: MealTransfer
    private let router: Router

    init(timeTracker: TimeTracker,
         mealTransfer: MealTransfer,
         router: Router) {
        self.timeTracker = timeTracker
        self.mealTransfer = mealTransfer
        self.router = router
    }

    func startMeal() {
        timeTracker.start()
    }

    func endMeal() {
        let meal = Meal(startTime: timeTracker.startTime)
        mealTransfer.transfer(meal: meal)
        router.route(to: MealSummaryView())
    }
}
