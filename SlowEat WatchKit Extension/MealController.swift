import WatchKit

class MealController: WKInterfaceController {

    var repository: CDMealRepository?
    var presenter: MealPresenter?

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        initPresenter()
    }

    private func initPresenter() {
        repository = CDMealRepository { [weak self] in
            guard let vc = self, let repository = vc.repository else { return }
            vc.presenter = MealPresenter(timeProvider: FoundationTimeProvider(),
                                         repository: repository,
                                         router: WKRouter(controller: vc))
        }
    }

    @IBAction func trackMeal() {
        presenter?.track()
    }
}
