import WatchConnectivity

class WKMealTransfer: NSObject, MealTransfer {

    private let session = WCSession.default

    private var isActive: Bool { return session.activationState == .activated }
    private var isSupported: Bool { return WCSession.isSupported() }

    private var meal: Meal?

    override init() {
        super.init()
        if isSupported {
            session.delegate = self
            session.activate()
        }
    }

    func transfer(meal: Meal) {
        self.meal = meal
        transfer(userInfo: ["Meal": meal.data])
    }

    private func transfer(userInfo: [String: Any]) {
        guard isSupported else { return }
        guard isActive else { return }
        session.transferUserInfo(userInfo)
        meal = nil
    }
}

extension WKMealTransfer: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        guard let meal = meal else { return }
        transfer(userInfo: ["Meal": meal.data])
    }
}
