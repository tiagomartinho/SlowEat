@testable import SlowEat
import XCTest

class MealDataTest: XCTestCase {

    func testSerialization() {
        let meal = Meal(startTime: 123, endTime: 456)
        let mealData = MealData(meal: meal)
        let data = NSKeyedArchiver.archivedData(withRootObject: mealData)
        let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
        let decodedMeal = unarchiver.decodeObject(forKey: "root") as? MealData
        XCTAssertEqual(decodedMeal?.meal, meal)
    }

    func testMealSerialization() {
        let meal = Meal(startTime: 123, endTime: 456)
        let otherMeal = Meal(any: meal.data)
        XCTAssertEqual(meal, otherMeal)
    }
}
