import WatchKit

class MealController: WKInterfaceController {

    private var presenter: MealPresenter?

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        if let presenter = context as? MealPresenter {
            self.presenter = presenter
        }
        presenter?.view = self
        presenter?.startMeal()
    }

    @IBAction func stopMeal() {
        presenter?.stopMeal()
    }
}

extension MealController: MealView {

    func showSummaryView() {
        WKInterfaceController.reloadRootPageControllers(withNames: ["SummaryView"],
                                                        contexts: nil,
                                                        orientation: .horizontal,
                                                        pageIndex: 0)
    }
}
