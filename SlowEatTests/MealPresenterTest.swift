import XCTest
@testable import SlowEat

class MealPresenterTest: XCTestCase {

    func testStartTrackingTimeWhenMealStarts() {
        presenter.startMeal()

        XCTAssert(timeTracker.startCalled)
    }

    func testShowMealViewWhenMealStarts() {
        presenter.startMeal()

        XCTAssert(view.showTrackingViewCalled)
    }

    func testTransferMealWhenMealEnds() {
        presenter.endMeal()

        XCTAssertNotNil(mealTransfer.mealTransfered)
    }

    func testRouteToSummaryViewWhenMealEnds() {
        presenter.endMeal()

        XCTAssert(router.routeToViewCalled)
    }

    // MARK: Test Support

    let view = SpyMealView()
    let timeTracker = SpyTimeTracker()
    let mealTransfer = SpyMealTransfer()
    let router = SpyRouter()
    var presenter: MealPresenter!

    override func setUp() {
        presenter = MealPresenter(view: view,
                                  timeTracker: timeTracker,
                                  mealTransfer: mealTransfer,
                                  router: router)
    }

    class SpyMealView: MealView {

        var showTrackingViewCalled = false

        func showTrackingView() {
            showTrackingViewCalled = true
        }
    }

    class SpyTimeTracker: TimeTracker {

        let startTime = 0.0

        var startCalled = false

        func start() {
            startCalled = true
        }
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
