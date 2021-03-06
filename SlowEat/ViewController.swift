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
        objectsDidChange()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        let meal = meals[indexPath.row]
        let duration = TimeFormatter.format(meal.endTime - meal.startTime)
        let date = Date(timeIntervalSince1970: meal.startTime)
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy HH:mm"
        cell?.textLabel?.text = "\(formatter.string(from: date)) - \(duration)"
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
