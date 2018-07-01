import XCTest
@testable import SlowEat

class MealSummaryPresenterTest: XCTestCase {

    let mealTransfer = SpyMealTransfer()
    let repository = SpyMealRepository()
    var presenter: MealSummaryPresenter!

    func testInitSyncsMealFromRepository() {
        let lastMeal = Meal(startTime: 123)
        repository.meals = [lastMeal]

        presenter = MealSummaryPresenter(mealTransfer: mealTransfer,
                                         repository: repository)

        XCTAssertEqual(lastMeal, mealTransfer.mealTransfered)
    }

    class SpyMealRepository: MealRepository {

        var meals: [Meal]!

        func save(_ meal: Meal) {}
        func fecth() -> [Meal] { return meals }
        func deleteAll() {}
    }

    class SpyMealTransfer: MealTransfer {

        var mealTransfered: Meal!

        func transfer(meal: Meal) {
            mealTransfered = meal
        }
    }
}
