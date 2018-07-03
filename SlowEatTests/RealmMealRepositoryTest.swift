import XCTest
@testable import SlowEat

class RealmMealRepositoryTest: XCTestCase {
    
    var repository: RealmMealRepository!
    
    func testSaveMealInRepository() {
        let expectation = XCTestExpectation(description: "")
        
        repository = RealmMealRepository()
        
        repository.deleteAll()
        let meal = Meal(startTime: 123, endTime: 456)
        
        repository.save(meal)
        
        repository.fecth() { meals in
            XCTAssert(meals.contains(meal))
            XCTAssertEqual(1, meals.count)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
}
