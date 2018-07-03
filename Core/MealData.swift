import Foundation

class MealData: NSObject, NSCoding {

    var meal: Meal?

    private static let startTimeKey = "startTimeKey"
    private static let endTimeKey = "endTimeKey"

    init(meal: Meal) {
        self.meal = meal
    }

    required init? (coder aDecoder: NSCoder) {
        guard let startTime = aDecoder.decodeObject(forKey: MealData.startTimeKey) as? Double else { return nil }
        guard let endTime = aDecoder.decodeObject(forKey: MealData.endTimeKey) as? Double else { return nil }
        meal = Meal(startTime: startTime, endTime: endTime)
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(meal?.startTime, forKey: MealData.startTimeKey)
        aCoder.encode(meal?.endTime, forKey: MealData.endTimeKey)
    }
}

extension Meal {

    var data: Data {
        let mealData = MealData(meal: self)
        NSKeyedArchiver.setClassName("MealData", for: MealData.self)
        return NSKeyedArchiver.archivedData(withRootObject: mealData)
    }

    init?(any: Any?) {
        guard let data = any as? Data else {
            return nil
        }
        let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
        NSKeyedUnarchiver.setClass(MealData.self, forClassName: "MealData")
        guard let mealData = unarchiver.decodeObject(forKey: "root") as? MealData,
            let meal = mealData.meal else {
                return nil
        }
        self = meal
    }
}
