import CoreData

class CDMealRepository: MealRepository {

    weak var delegate: MealRepositoryDelegate?

    private let managedObjectContext: NSManagedObjectContext
    private var notificationObserver: NSObjectProtocol?

    init(completionClosure: @escaping () -> ()) {
        guard let modelURL = Bundle.main.url(forResource: "MealModel", withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }

        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = psc
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
                                                                                     object: strongSelf.managedObjectContext,
                                                                                     queue: nil) { notification in
                print("NSManagedObjectContextObjectsDidChange")
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
            let mealMO = NSEntityDescription.insertNewObject(forEntityName: "Meal", into: managedObjectContext) as? MealMO
            mealMO?.startTime = Date(timeIntervalSince1970: meal.startTime)
            try managedObjectContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }

    func deleteAll() {
        fecthMO().forEach { managedObjectContext.delete($0) }
    }

    func fecth() -> [Meal] {
        return fecthMO().compactMap { $0.startTime?.timeIntervalSince1970 }.compactMap { Meal(startTime: $0) }
    }

    private func fecthMO() -> [MealMO] {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Meal")
        do {
            guard let meals = try managedObjectContext.fetch(fetch) as? [MealMO] else { return [] }
            return meals
        } catch {
            fatalError("Failed to fetch: \(error)")
        }
    }
}
