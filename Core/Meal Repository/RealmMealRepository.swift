import Foundation
import RealmSwift

class RealmMealRepository: MealRepository {

    weak var delegate: MealRepositoryDelegate?

    private var realm: Realm?
    private var token: NotificationToken?

    init() {
        realm = try? Realm()
        token = realm?.observe { notification, realm in
            self.delegate?.objectsDidChange()
        }
    }

    deinit {
        token?.invalidate()
    }

    func save(_ meal: Meal) {
        DispatchQueue.main.async {
            try? self.realm?.write {
                let realmMeal = RealmMeal()
                realmMeal.set(meal)
                self.realm?.add(realmMeal)
            }
        }
    }

    func fecth(completionHandler: @escaping ([Meal]) -> Void) {
        DispatchQueue.main.async {
            guard let objects = self.realm?.objects(RealmMeal.self) else {
                completionHandler([])
                return
            }
            let meals = Array(objects).map {
                $0.meal
            }
            completionHandler(meals)
        }
    }

    func deleteAll() {
        DispatchQueue.main.async {
            try? self.realm?.write {
                self.realm?.deleteAll()
            }
        }
    }
}

class RealmMeal: Object {

    @objc dynamic var startTime = 0.0
    @objc dynamic var endTime = 0.0

    func set(_ meal: Meal) {
        startTime = meal.startTime
        endTime = meal.endTime
    }

    var meal: Meal {
        return Meal(startTime: startTime, endTime: endTime)
    }
}
