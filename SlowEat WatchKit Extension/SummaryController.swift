import WatchKit

class SummaryController: WKInterfaceController {

    @IBAction func endMeal() {
        WKInterfaceController.reloadRootPageControllers(withNames: ["InitialView"],
                                                        contexts: nil,
                                                        orientation: .horizontal,
                                                        pageIndex: 0)
    }
}
