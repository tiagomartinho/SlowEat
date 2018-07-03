class MealPresenter {

    private weak var view: MealView?
    private let timeTracker: TimeTracker
    private let mealTransfer: MealTransfer
    private let router: Router

    init(view: MealView,
         timeTracker: TimeTracker,
         mealTransfer: MealTransfer,
         router: Router) {
        self.view = view
        self.timeTracker = timeTracker
        self.mealTransfer = mealTransfer
        self.router = router
    }

    func startMeal() {
        timeTracker.start()
        view?.showTrackingView()
    }

    func stopMeal() {
        let meal = Meal(startTime: timeTracker.startTime)
        mealTransfer.transfer(meal: meal)
        router.route(to: MealSummaryView())
    }
}
