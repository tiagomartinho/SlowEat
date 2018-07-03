import WatchKit

class MealController: WKInterfaceController {

    lazy var presenter = MealPresenter(timeProvider: FoundationTimeProvider(),
                                  mealTransfer: WKMealTransfer(),
                                  router: WKRouter(controller: self))
}
