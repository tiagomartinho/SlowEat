import UIKit

class ViewController: UIViewController {

    private var mealRepository: CDMealRepository?

    override func viewDidLoad() {
        super.viewDidLoad()
        mealRepository = CDMealRepository {
            self.mealRepository?.fecth().forEach { print($0) }
        }
        mealRepository?.delegate = self
    }
}

extension ViewController: MealRepositoryDelegate {
    func objectsDidChange() {
        print("objectsDidChange")
        mealRepository?.fecth().forEach { print($0) }
    }
}
