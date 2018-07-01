import UIKit

class ViewController: UIViewController {

    var repository: CDMealRepository?
    var presenter: MealPresenter? {
        didSet {
            repository?.fecth().forEach { print($0) }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        repository = CDMealRepository { [weak self] in
            guard let vc = self, let repository = vc.repository else { return }
            vc.presenter = MealPresenter(timeProvider: FoundationTimeProvider(),
                                            repository: repository,
                                            router: UIKitRouter())
        }
    }
}
