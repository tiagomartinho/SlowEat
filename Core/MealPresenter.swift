class MealPresenter {

    private let timeProvider: TimeProvider
    private let mealTransfer: MealTransfer
    private let router: Router

    init(timeProvider: TimeProvider,
         mealTransfer: MealTransfer,
         router: Router) {
        self.timeProvider = timeProvider
        self.mealTransfer = mealTransfer
        self.router = router
    }

    func track() {
        let meal = Meal(startTime: timeProvider.currentTime)
        mealTransfer.transfer(meal: meal)
        router.route(to: MealSummaryView())
    }
}
