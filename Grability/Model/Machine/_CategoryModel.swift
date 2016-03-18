// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CategoryModel.swift instead.

import CoreData

public enum CategoryModelAttributes: String {
    case category = "category"
}

public enum CategoryModelRelationships: String {
    case application = "application"
}

@objc public
class _CategoryModel: NSManagedObject {

    // MARK: - Class methods

    public class func entityName () -> String {
        return "Category"
    }

    public class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    public convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _CategoryModel.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged public
    var category: String?

    // func validateCategory(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    // MARK: - Relationships

    @NSManaged public
    var application: NSSet

}

extension _CategoryModel {

    func addApplication(objects: NSSet) {
        let mutable = self.application.mutableCopy() as! NSMutableSet
        mutable.unionSet(objects as! Set<NSObject>)
        self.application = mutable.copy() as! NSSet
    }

    func removeApplication(objects: NSSet) {
        let mutable = self.application.mutableCopy() as! NSMutableSet
        mutable.minusSet(objects as! Set<NSObject>)
        self.application = mutable.copy() as! NSSet
    }

    func addApplicationObject(value: ApplicationModel!) {
        let mutable = self.application.mutableCopy() as! NSMutableSet
        mutable.addObject(value)
        self.application = mutable.copy() as! NSSet
    }

    func removeApplicationObject(value: ApplicationModel!) {
        let mutable = self.application.mutableCopy() as! NSMutableSet
        mutable.removeObject(value)
        self.application = mutable.copy() as! NSSet
    }

}

