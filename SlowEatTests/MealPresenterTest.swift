import XCTest
@testable import SlowEat

class MealPresenterTest: XCTestCase {

    func testStartTrackingTimeWhenMealStarts() {
        presenter.startMeal()

        XCTAssert(timeTracker.startCalled)
    }

    func testTimerTickUpdatesMealTime() {
        timeTracker.currentTime = 83

        presenter.tick()

        XCTAssertEqual("01:23", trackingView.mealTime)
    }

    func testTransferMealWhenMealStops() {
        presenter.stopMeal()

        XCTAssertNotNil(mealTransfer.mealTransfered)
    }

    func testTrackMealWithCorrectTime() {
        timeTracker.startTime = 83
        timeTracker.currentTime = 124

        presenter.stopMeal()

        XCTAssertEqual(83, mealTransfer.mealTransfered.startTime)
        XCTAssertEqual(124, mealTransfer.mealTransfered.endTime)
    }

    func testShowSummaryViewWhenMealStops() {
        presenter.stopMeal()

        XCTAssert(controlsView.showSummaryViewCalled)
    }

    func testSubscribeToTimerUpdates() {
        presenter.activateViewUpdates()

        XCTAssert(timer.startCalled)
        XCTAssert(timer.delegate is MealPresenter)
    }

    func testUnsubscribeToTimerUpdates() {
        presenter.deactivateViewUpdates()

        XCTAssert(timer.stopCalled)
        XCTAssertNil(timer.delegate)
    }

    // MARK: Test Support

    let controlsView = SpyMealControlsView()
    let trackingView = SpyMealTrackingView()
    let timeTracker = SpyTimeTracker()
    let mealTransfer = SpyMealTransfer()
    let timer = SpyTimer()
    var presenter: MealPresenter!

    override func setUp() {
        presenter = MealPresenter(timeTracker: timeTracker,
                                  timer: timer,
                                  mealTransfer: mealTransfer)
        presenter.trackingView = trackingView
        presenter.controlsView = controlsView
    }

    class SpyMealControlsView: MealControlsView {

        var showSummaryViewCalled = false

        func showSummaryView() {
            showSummaryViewCalled = true
        }
    }

    class SpyMealTrackingView: MealTrackingView {

        var mealTime: String!

        func showMealTime(_ time: String) {
            mealTime = time
        }
    }

    class SpyTimeTracker: TimeTracker {

        var currentTime = 0.0
        var startTime = 0.0

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

    class SpyTimer: SlowEat.Timer {

        weak var delegate: TimerDelegate?

        var startCalled = false

        func start() {
            startCalled = true
        }

        var stopCalled = false

        func stop() {
            stopCalled = true
        }
    }
}
