import WatchKit

class InitialController: WKInterfaceController {

    @IBOutlet var motivationLabel: WKInterfaceLabel!

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        motivationLabel.setText(MotivationalQuotes.random)
    }

    override func willDisappear() {
        super.willDisappear()
        motivationLabel.setText(MotivationalQuotes.random)
    }
}
