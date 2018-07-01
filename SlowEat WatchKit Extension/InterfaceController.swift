import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {

    let presenter = MealPresenter(timeProvider: FoundationTimeProvider(),
                                  repository: CDMealRepository { },
                                  router: WKRouter())

    @IBAction func trackMeal() {
        presenter.track()
    }
}
