import WatchKit

class MealController: WKInterfaceController {

    lazy var presenter = MealPresenter(view: self,
                                       timeTracker: FoundationTimeTracker(),
                                  mealTransfer: WKMealTransfer(),
                                  router: WKRouter(controller: self))

    @IBOutlet var motivationLabel: WKInterfaceLabel!

    override func willActivate() {
        super.willActivate()
        motivationLabel.setText(MotivationalQuotes.random)
    }

    @IBAction func startMeal() {
        presenter.endMeal()
    }
}

extension MealController: MealView {
    func showTrackingView() {
    }
}
