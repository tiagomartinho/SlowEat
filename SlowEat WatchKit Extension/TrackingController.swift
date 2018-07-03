import WatchKit

class TrackingController: WKInterfaceController {

    @IBOutlet var timeLabel: WKInterfaceLabel!

    private var presenter: MealPresenter?
    private var timer: Timer?

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
        startTimer()
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.5,
                                     target: self,
                                     selector: #selector(update),
                                     userInfo: nil,
                                     repeats: true)
        timer?.tolerance = 0.5
    }

    @objc func update() {
        presenter?.update()
    }

    override func didDeactivate() {
        super.didDeactivate()
        stopTimer()
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

extension TrackingController: MealTrackingView {
    
    func showMealTime(_ time: String) {
        timeLabel?.setText(time)
    }
}
