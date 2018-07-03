import WatchKit

class MealController: WKInterfaceController {

    lazy var presenter = MealPresenter(view: self,
                                       timeTracker: FoundationTimeTracker(),
                                  mealTransfer: WKMealTransfer())

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

    @IBAction func endMeal() {
        presenter.endMeal()
    }
}

extension MealController: MealView {

    func showSummaryView() {
        reload(controllers: ["SummaryView"])
    }
    
    func showInitialView() {
        reload(controllers: ["InitialView"])
    }

    func showTrackingView() {
        reload(controllers: ["TrackingView", "StopView"])
    }

    private func reload(controllers: [String]) {
        WKInterfaceController.reloadRootPageControllers(withNames: controllers,
                                                        contexts: nil,
                                                        orientation: .horizontal,
                                                        pageIndex: 0)
    }
}
