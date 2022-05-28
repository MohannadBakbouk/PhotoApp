//
//  CoreDataManager.swift
//  PhotoApp
//
//  Created by Mohannad on 5/27/22.
//
import CoreData
import class UIKit.UIApplication

class CoreDataManager {
    
    private let modelName : String
    
    private lazy var persistenContainer : NSPersistentContainer! = {
        let container = NSPersistentContainer(name: modelName)
        return container
    }()
    
    lazy var backgroundContext : NSManagedObjectContext = {
        let context = self.persistenContainer.newBackgroundContext()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }()
    
    lazy var mainContext : NSManagedObjectContext = {
        let context = self.persistenContainer.newBackgroundContext()
        context.automaticallyMergesChangesFromParent = true
        return context
    }()
    
    init(modelName : String) {
        self.modelName = modelName
    }
    
    private func loadPersistentStore(completion : @escaping () ->()){
        persistenContainer.loadPersistentStores { description, error in
            guard error == nil else {return}
            completion()
        }
    }
    
    @objc private func saveChanges(){
        mainContext.performAndWait {
            do {
                guard mainContext.hasChanges else {return }
                try mainContext.save()
                self.backgroundContext.perform {
                    do {
                        try self.backgroundContext.save()
                    }
                    catch{
                        print("Unable to Save Changes of banckground Managed Object Context")
                    }
                }
            }
            catch{
                print(error)
                print("Unable to Save Changes of Main Managed Object Context")
            }
        }
    }
    
    private func setupNotifications(){
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector : #selector(saveChanges), name: UIApplication.willResignActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(saveChanges), name: UIApplication.willTerminateNotification, object: nil)
    }
 }

extension CoreDataManager : CoreDataManagerProtocol {
    
    func setup(completion : @escaping (() ->()) ){
        loadPersistentStore {
            completion()
        }
    }
    
    func fetch<T: NSManagedObject>(entity : T.Type) -> [T]? {
        let entityName = String(describing: T.self)
        let request  = NSFetchRequest<T>(entityName: entityName)
        var results : [T]? = nil
        request.sortDescriptors = []
        mainContext.performAndWait {
            results = try?  request.execute()
        }
        return results
    }
    
    func delete<T: NSManagedObject>(entity : T){
        mainContext.delete(entity)
    }
    
    func deleteAll<T:NSManagedObject>(entity : T.Type) {
        let entityName = String(describing: T.self)
        let request  = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        _ = try? mainContext.execute(deleteRequest)
    }
    
    func add<T:NSManagedObject , S : AnyObject>(type : T.Type , entities : [S]){
        backgroundContext.perform {[weak self] in
            guard let self = self else {return}
            for item in entities {
                let managedInfo   = T.init(context: self.backgroundContext)
                managedInfo.populate(with: item)
            }
            try? self.backgroundContext.save()
        }
    }

}
