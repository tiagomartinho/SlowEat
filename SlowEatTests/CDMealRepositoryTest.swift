import XCTest
@testable import SlowEat

class CDMealRepositoryTest: XCTestCase {

    var repository: CDMealRepository!

    func testSaveMealInRepository() {
        let expectation = XCTestExpectation(description: "")

        repository = CDMealRepository {
            let meal = Meal(startTime: 123)
            let numberOfMeals = self.repository.fecth().count

            self.repository.save(meal)

            let meals = self.repository.fecth()
            XCTAssert(meals.contains(meal))
            XCTAssertEqual(numberOfMeals + 1, meals.count)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }
}
