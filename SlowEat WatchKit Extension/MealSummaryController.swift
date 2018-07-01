import WatchKit

class MealSummaryController: WKInterfaceController {

    var repository: CDMealRepository?
    var presenter: MealSummaryPresenter?

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        initPresenter()
    }

    private func initPresenter() {
        repository = CDMealRepository { [weak self] in
            guard let vc = self, let repository = vc.repository else { return }
            vc.presenter = MealSummaryPresenter(mealTransfer: WKMealTransfer(),
                                         repository: repository)
        }
    }
}
