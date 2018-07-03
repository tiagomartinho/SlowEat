import XCTest
@testable import SlowEat

class MealPresenterTest: XCTestCase {

    let mealTransfer = SpyMealTransfer()
    let router = SpyRouter()
    var presenter: MealPresenter!

    override func setUp() {
        presenter = MealPresenter(timeProvider: FoundationTimeProvider(),
                                      mealTransfer: mealTransfer,
                                      router: router)
    }

    func testTransferMealWhenMealEnds() {
        presenter.endMeal()

        XCTAssertNotNil(mealTransfer.mealTransfered)
    }

    func testRouteToSummaryViewWhenMealEnds() {
        presenter.endMeal()

        XCTAssert(router.routeToViewCalled)
    }

    class SpyMealTransfer: MealTransfer {

        var mealTransfered: Meal!

        func transfer(meal: Meal) {
            mealTransfered = meal
        }
    }

    class SpyRouter: Router {

        var routeToViewCalled = false

        func route(to view: View) {
            routeToViewCalled = true
        }
    }
}
