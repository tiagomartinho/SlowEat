import XCTest
@testable import SlowEat

class MealUseCaseTests: XCTestCase {

    func testTrackMealSavesItInRepository() {
        let repository = SpyMealRepository()
        let useCase = MealUseCase(repository: repository)

        useCase.trackMeal()

        XCTAssert(repository.saveWasCalled)
    }

    class SpyMealRepository: MealRepository {

        var saveWasCalled = false

        func save(_ meal: Meal) {
            saveWasCalled = true
        }
    }
}
