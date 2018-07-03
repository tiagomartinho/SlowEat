import UIKit

class ViewController: UITableViewController {

    private var mealRepository: RealmMealRepository?
    private var meals = [Meal]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteMeals))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        mealRepository = RealmMealRepository()
        mealRepository?.delegate = self
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        let meal = meals[indexPath.row]
        let duration = TimeFormatter.format(meal.endTime - meal.startTime)
        cell?.textLabel?.text = "\(meal.startTime) -> \(meal.endTime) : \(duration)"
        return cell!
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }

    @objc func deleteMeals() {
        mealRepository?.deleteAll()
    }
}

extension ViewController: MealRepositoryDelegate {
    func objectsDidChange() {
        mealRepository?.fecth { [weak self] meals in
            guard let strongSelf = self else { return }
            strongSelf.meals = meals
        }
    }
}
