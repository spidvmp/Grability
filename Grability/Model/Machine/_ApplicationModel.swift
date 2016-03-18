// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ApplicationModel.swift instead.

import CoreData

public enum ApplicationModelAttributes: String {
    case date = "date"
    case name = "name"
    case price = "price"
    case rights = "rights"
    case summary = "summary"
}

public enum ApplicationModelRelationships: String {
    case category = "category"
    case photo = "photo"
}

@objc public
class _ApplicationModel: NSManagedObject {

    // MARK: - Class methods

    public class func entityName () -> String {
        return "Application"
    }

    public class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    public convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _ApplicationModel.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged public
    var date: String?

    // func validateDate(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged public
    var name: String?

    // func validateName(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged public
    var price: String?

    // func validatePrice(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged public
    var rights: String?

    // func validateRights(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged public
    var summary: String?

    // func validateSummary(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    // MARK: - Relationships

    @NSManaged public
    var category: CategoryModel?

    // func validateCategory(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged public
    var photo: PhotoModel?

    // func validatePhoto(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

}

