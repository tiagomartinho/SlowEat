import WatchKit

class TrackingController: WKInterfaceController {

    @IBOutlet var timeLabel: WKInterfaceLabel!

    private var presenter: MealPresenter?

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        if let presenter = context as? MealPresenter {
            self.presenter = presenter
        }
        presenter?.trackingView = self
        presenter?.startMeal()
    }

    override func willActivate() {
        super.willActivate()
        presenter?.activateViewUpdates()
    }

    override func didDeactivate() {
        super.didDeactivate()
        presenter?.deactivateViewUpdates()
    }
}

extension TrackingController: MealTrackingView {
    
    func show(mealTime: String) {
        timeLabel?.setText(mealTime)
    }
}
