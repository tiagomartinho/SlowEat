import CoreData

class CDMealRepository: MealRepository {

    weak var delegate: MealRepositoryDelegate?

    private static var sharedContext: NSManagedObjectContext?

    private let context: NSManagedObjectContext
    private var notificationObserver: NSObjectProtocol?

    init(completionClosure: @escaping () -> ()) {
        guard let modelURL = Bundle.main.url(forResource: "MealModel", withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }

        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        if CDMealRepository.sharedContext != nil {
            context = CDMealRepository.sharedContext!
        } else {
            context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            context.persistentStoreCoordinator = psc
            CDMealRepository.sharedContext = context
        }
        let queue = DispatchQueue.global(qos: .background)
        queue.async { [weak self] in
            guard let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
                fatalError("Unable to resolve document directory")
            }
            let storeURL = docURL.appendingPathComponent("MealModel.sqlite")
            do {
                try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
                DispatchQueue.main.sync(execute: completionClosure)
            } catch {
                fatalError("Error migrating store: \(error)")
            }
            guard let strongSelf = self else { return }
            let name = NSNotification.Name.NSManagedObjectContextObjectsDidChange
            strongSelf.notificationObserver = NotificationCenter.default.addObserver(forName: name,
                                                                                     object: strongSelf.context,
                                                                                     queue: nil) { notification in
                strongSelf.delegate?.objectsDidChange()
            }
        }
    }

    deinit {
        if let notificationObserver = notificationObserver {
            NotificationCenter.default.removeObserver(notificationObserver)
        }
    }

    func save(_ meal: Meal) {
        do {
            let mealMO = NSEntityDescription.insertNewObject(forEntityName: "Meal", into: context) as? MealMO
            mealMO?.startTime = Date(timeIntervalSince1970: meal.startTime)
            try context.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }

    func deleteAll() {
        fecthMO().forEach { context.delete($0) }
    }

    func fecth() -> [Meal] {
        return fecthMO().compactMap { (mealMO) in
            if let startTime = mealMO.startTime?.timeIntervalSince1970,
                let endTime = mealMO.endTime?.timeIntervalSince1970 {
                return Meal(startTime: startTime, endTime: endTime)
            } else {
                return nil
            }
        }
    }

    private func fecthMO() -> [MealMO] {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Meal")
        do {
            guard let meals = try context.fetch(fetch) as? [MealMO] else { return [] }
            return meals
        } catch {
            fatalError("Failed to fetch: \(error)")
        }
    }
}
