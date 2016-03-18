// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PhotoModel.swift instead.

import CoreData

public enum PhotoModelAttributes: String {
    case data = "data"
    case url = "url"
}

public enum PhotoModelRelationships: String {
    case application = "application"
}

@objc public
class _PhotoModel: NSManagedObject {

    // MARK: - Class methods

    public class func entityName () -> String {
        return "Photo"
    }

    public class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    public convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _PhotoModel.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged public
    var data: NSData?

    // func validateData(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged public
    var url: String?

    // func validateUrl(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    // MARK: - Relationships

    @NSManaged public
    var application: ApplicationModel?

    // func validateApplication(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

}

