protocol MealRepository {
    func save(_ meal: Meal)
    func fecth() -> [Meal]
    func deleteAll()
}
