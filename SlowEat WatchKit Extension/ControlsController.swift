import WatchKit

class ControlsController: WKInterfaceController {

    private var presenter: MealPresenter?

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        if let presenter = context as? MealPresenter {
            self.presenter = presenter
        }
        presenter?.controlsView = self
    }

    @IBAction func stopMeal() {
        presenter?.stopMeal()
    }
}

extension ControlsController: MealControlsView {

    func showSummaryView() {
        WKInterfaceController.reloadRootPageControllers(withNames: ["SummaryView"],
                                                        contexts: nil,
                                                        orientation: .horizontal,
                                                        pageIndex: 0)
    }
}
