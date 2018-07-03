import WatchKit

class MealController: WKInterfaceController {

    lazy var presenter = MealPresenter(view: self,
                                       timeTracker: FoundationTimeTracker(),
                                  mealTransfer: WKMealTransfer(),
                                  router: WKRouter(controller: self))

    @IBOutlet var motivationLabel: WKInterfaceLabel!

    override func willActivate() {
        super.willActivate()
        motivationLabel?.setText(MotivationalQuotes.random)
    }

    @IBAction func startMeal() {
        presenter.startMeal()
    }

    @IBAction func stopMeal() {
        presenter.stopMeal()
    }
}

extension MealController: MealView {
    func showTrackingView() {
        let controllers = ["TrackingView", "StopView"]
        WKInterfaceController.reloadRootPageControllers(withNames: controllers,
                                                        contexts: nil,
                                                        orientation: .horizontal,
                                                        pageIndex: 0)
    }
}
