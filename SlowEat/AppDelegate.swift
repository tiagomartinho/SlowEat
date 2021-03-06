import UIKit
import WatchConnectivity

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private let mealRepository = RealmMealRepository()
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        activateWatchSession()
        setRootViewController()
        return true
    }
    
    private func setRootViewController() {
        window = UIWindow()
        let rootViewController = UINavigationController(rootViewController: ViewController())
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
    
    private func activateWatchSession() {
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
}

extension AppDelegate: WCSessionDelegate {
    func sessionDidBecomeInactive(_ session: WCSession) {}
    func sessionDidDeactivate(_ session: WCSession) {}
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        guard let meal = Meal(any: userInfo["Meal"]) else { return }
        mealRepository.save(meal)
    }
}
