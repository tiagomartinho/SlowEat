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
        presenter.stopMeal()

        XCTAssertNotNil(mealTransfer.mealTransfered)
    }

    func testShowSummaryViewWhenMealEnds() {
        presenter.stopMeal()

        XCTAssert(view.showSummaryViewCalled)
    }

    // MARK: Test Support

    let view = SpyMealView()
    let timeTracker = SpyTimeTracker()
    let mealTransfer = SpyMealTransfer()
    var presenter: MealPresenter!

    override func setUp() {
        presenter = MealPresenter(view: view,
                                  timeTracker: timeTracker,
                                  mealTransfer: mealTransfer)
    }

    class SpyMealView: MealView {

        var showTrackingViewCalled = false
        var showInitialViewCalled = false
        var showSummaryViewCalled = false

        func showTrackingView() {
            showTrackingViewCalled = true
        }

        func showInitialView() {
            showInitialViewCalled = true
        }

        func showSummaryView() {
            showSummaryViewCalled = true
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
}
