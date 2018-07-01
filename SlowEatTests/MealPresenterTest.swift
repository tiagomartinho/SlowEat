import XCTest
@testable import SlowEat

class MealPresenterTest: XCTestCase {

    func testTrackMealSavesItInRepository() {
        let repository = SpyMealRepository()
        let presenter = MealPresenter(timeProvider: FoundationTimeProvider(),
                                      repository: repository)

        presenter.track()

        XCTAssert(repository.saveWasCalled)
    }

    class SpyMealRepository: MealRepository {

        var saveWasCalled = false

        func save(_ meal: Meal) {
            saveWasCalled = true
        }
    }
}
