import UIKit
import WatchConnectivity

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private var mealRepository: CDMealRepository?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        initMealRepository()
        setRootViewController()
        return true
    }

    private func setRootViewController() {
        window = UIWindow()
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
    }

    private func initMealRepository() {
        mealRepository = CDMealRepository {
            if WCSession.isSupported() {
                WCSession.default.delegate = self
                WCSession.default.activate()
            }
        }
    }
}

extension AppDelegate: WCSessionDelegate {
    func sessionDidBecomeInactive(_ session: WCSession) {}
    func sessionDidDeactivate(_ session: WCSession) {}
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}

    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        guard let meal = Meal(any: userInfo["Meal"]) else { return }
        mealRepository?.save(meal)
    }
}
