class MealSummaryPresenter {

    private let mealTransfer: MealTransfer
    private let repository: MealRepository

    init(mealTransfer: MealTransfer,
         repository: MealRepository) {
        self.mealTransfer = mealTransfer
        self.repository = repository
        transferLastMeal()
    }

    private func transferLastMeal() {
        if let lastMeal = repository.fecth().last {
            mealTransfer.transfer(meal: lastMeal)
        }
    }
}
