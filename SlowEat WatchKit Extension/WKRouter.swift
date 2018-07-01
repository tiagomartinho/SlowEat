import WatchKit

class WKRouter: Router {

    let controller: WKInterfaceController

    init(controller: WKInterfaceController) {
        self.controller = controller
    }

    func route(to view: View) {
        controller.presentController(withName: view.name, context: nil)
    }
}
