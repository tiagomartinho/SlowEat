import UIKit

class ViewController: UIViewController {

    let presenter = MealPresenter(timeProvider: FoundationTimeProvider(),
                                  repository: CDMealRepository { })

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.track()
    }
}
