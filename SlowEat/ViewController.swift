import UIKit

class ViewController: UITableViewController {

    private var mealRepository: CDMealRepository?
    private var meals = [Meal]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        mealRepository = CDMealRepository(completionClosure: objectsDidChange)
        mealRepository?.delegate = self
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        cell?.textLabel?.text = "\(indexPath.row) \(meals[indexPath.row].startTime)"
        return cell!
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
}

extension ViewController: MealRepositoryDelegate {
    func objectsDidChange() {
        meals = mealRepository?.fecth() ?? []
    }
}
