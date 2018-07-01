class MealPresenter {

    private let timeProvider: TimeProvider
    private let repository: MealRepository

    init(timeProvider: TimeProvider,
         repository: MealRepository) {
        self.timeProvider = timeProvider
        self.repository = repository
    }

    func track() {
        let meal = Meal(startTime: timeProvider.currentTime)
        repository.save(meal)
    }
}
