protocol MealRepository {
    var delegate: MealRepositoryDelegate? { get set }
    func save(_ meal: Meal)
    func fecth(completionHandler: @escaping ([Meal]) -> Void)
    func deleteAll()
}
