class MealUseCase {

    let repository: MealRepository

    init(repository: MealRepository) {
        self.repository = repository
    }

    func trackMeal() {
        repository.save(Meal())
    }
}
