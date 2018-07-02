import UIKit

class ViewController: UIViewController {

    private var mealRepository: CDMealRepository?

    override func viewDidLoad() {
        super.viewDidLoad()
        mealRepository = CDMealRepository {
            let meals = self.mealRepository?.fecth() ?? []
            print("meals \(meals.count)")
            meals.forEach { print($0) }
        }
        mealRepository?.delegate = self
    }
}

extension ViewController: MealRepositoryDelegate {
    func objectsDidChange() {
        let meals = mealRepository?.fecth() ?? []
        print("meals \(meals.count)")
        meals.forEach { print($0) }
    }
}
