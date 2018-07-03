import WatchKit

class MealController: WKInterfaceController {

    lazy var presenter = MealPresenter(timeProvider: FoundationTimeProvider(),
                                  mealTransfer: WKMealTransfer(),
                                  router: WKRouter(controller: self))

    @IBOutlet var motivationLabel: WKInterfaceLabel!

    override func willActivate() {
        super.willActivate()
        motivationLabel.setText(MotivationalQuotes.random)
    }

    @IBAction func startMeal() {
        presenter.track()
    }
}
