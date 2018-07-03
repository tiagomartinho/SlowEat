import WatchKit

class InitialController: WKInterfaceController {

    @IBOutlet var motivationLabel: WKInterfaceLabel!

    override func willActivate() {
        super.willActivate()
        motivationLabel?.setText(MotivationalQuotes.random)
    }

    @IBAction func startMeal() {
        let presenter = MealPresenter(timeTracker: FoundationTimeTracker(),
                                           mealTransfer: WKMealTransfer())
        WKInterfaceController.reloadRootPageControllers(withNames: ["TrackingView", "StopView"],
                                                        contexts: [presenter, presenter],
                                                        orientation: .horizontal,
                                                        pageIndex: 0)
    }
}
