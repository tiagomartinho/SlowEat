import WatchConnectivity

class WKMealTransfer: NSObject, MealTransfer {

    private let session = WCSession.default
    private var isActive: Bool { return session.activationState == .activated }
    private var isSupported: Bool { return WCSession.isSupported() }
    private var userInfo: [String: Any]?

    override init() {
        super.init()
        if isSupported {
            session.delegate = self
            session.activate()
        }
    }

    func transfer(meal: Meal) {
        transfer(userInfo: ["Meal": meal.data])
    }

    private func transfer(userInfo: [String: Any]) {
        guard isSupported else { return }
        guard isActive else { self.userInfo = userInfo; return }
        session.transferUserInfo(userInfo)
        self.userInfo = nil
    }
}

extension WKMealTransfer: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        guard let userInfo = userInfo else { return }
        transfer(userInfo: userInfo)
    }
}
