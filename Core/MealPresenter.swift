class MealPresenter {

    let timeProvider: TimeProvider
    let repository: MealRepository

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
