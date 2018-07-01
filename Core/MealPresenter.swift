class MealPresenter {

    private let timeProvider: TimeProvider
    private let repository: MealRepository
    private let router: Router

    init(timeProvider: TimeProvider,
         repository: MealRepository,
         router: Router) {
        self.timeProvider = timeProvider
        self.repository = repository
        self.router = router
    }

    func track() {
        let meal = Meal(startTime: timeProvider.currentTime)
        repository.save(meal)
        router.route(to: MealSummaryView())
    }
}
