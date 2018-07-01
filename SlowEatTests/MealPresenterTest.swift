import XCTest
@testable import SlowEat

class MealPresenterTest: XCTestCase {

    let repository = SpyMealRepository()
    let router = SpyRouter()
    var presenter: MealPresenter!

    override func setUp() {
        presenter = MealPresenter(timeProvider: FoundationTimeProvider(),
                                      repository: repository,
                                      router: router)
    }

    func testTrackMealSavesItInRepository() {
        presenter.track()

        XCTAssert(repository.saveWasCalled)
    }

    func testRouteToSummaryViewAfterTrack() {
        presenter.track()

        XCTAssert(router.routeToViewCalled)
    }

    class SpyMealRepository: MealRepository {

        var saveWasCalled = false

        func save(_ meal: Meal) {
            saveWasCalled = true
        }

        func fecth() -> [Meal] { return [] }
        func deleteAll() {}
    }

    class SpyRouter: Router {

        var routeToViewCalled = false

        func route(to view: View) {
            routeToViewCalled = true
        }
    }
}
