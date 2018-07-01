import XCTest
@testable import SlowEat

class CDMealRepositoryTest: XCTestCase {

    var repository: CDMealRepository!

    func testSaveMealInRepository() {
        let expectation = XCTestExpectation(description: "")

        repository = CDMealRepository {
            self.repository.deleteAll()
            let meal = Meal(startTime: 123)

            self.repository.save(meal)

            let meals = self.repository.fecth()
            XCTAssert(meals.contains(meal))
            XCTAssertEqual(1, meals.count)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }
}
